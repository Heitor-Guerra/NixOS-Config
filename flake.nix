{
  description = "Heitor's NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      disko,
      ...
    }@inputs:
    let
      # Change accordingly
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      vars = import ./vars.nix { inherit pkgs; };
    in
    {
      # Main NixOS Config
      nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit pkgs;
        specialArgs = { inherit vars; };
        modules = [
          disko.nixosModules.disko
          ./diskPartitioning/disk.nix
          ./configuration.nix

          # Integrate Home-Manager as a NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";

            home-manager.extraSpecialArgs = { inherit vars; };
            home-manager.users.${vars.username} = {
              imports = [ ./home/home.nix ];

              home.username = vars.username;
              home.homeDirectory = "/home/${vars.username}";
              home.stateVersion = "26.05";
            };
          }
        ];
      };

      #
      #
      # Disko's disk partitioning.
      apps.${system}.disko =
        let
          runDisko = pkgs.writeShellApplication {
            name = "apply-disko";

            runtimeInputs = [
              disko.packages.${system}.disko
              pkgs.coreutils
            ];

            text = ''
              echo "Disk layout for: ${vars.hostname}"
              echo "Target device: ${vars.mainDevice}"
              echo
              echo "WARNING: Disko may erase data on the target disk."
              read -r -p 'Type APPLY to continue: ' answer

              if [[ "$answer" != "APPLY" ]]; then
                echo "Cancelled."
                exit 1
              fi

              exec disko \
                --mode disko \
                --flake "${self}#${vars.hostname}"
            '';
          };
        in
        {
          type = "app";
          program = "${runDisko}/bin/apply-disko";
        };

      #
      #
      # Installer to Bootable Drive
      nixosConfigurations.installer = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit pkgs;

        specialArgs = {
          inherit self vars;
          diskoInstall = disko.packages.${system}.disko-install;
        };

        modules = [
          ./installer/iso.nix
        ];
      };

      packages.${system}.installer-iso = self.nixosConfigurations.installer.config.system.build.isoImage;
    };
}
