{
  description = "Parking confirmation program + service";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        # Build the Rust binary
        packages.default = pkgs.rustPlatform.buildRustPackage {
          pname = "apcoabot";
          version = "0.1.0";
          src = ./.;

          cargoLock = {
            lockFile = ./Cargo.lock;
          };

          nativeBuildInputs = [pkgs.pkg-config];
          buildInputs = [
            pkgs.openssl
          ];

          # PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
        };

        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            rustc
            cargo
            cargo-watch
            rustfmt
            clippy
            rust-analyzer
            openssl
            pkg-config
          ];
        };
      }
    )
    // {
      ### NixOS module that provides:
      # - programs.parking.enable (installs CLI)
      # - services.parking.enable (runs service + timer)
      nixosModules.default = {
        config,
        lib,
        ...
      }: let
        cfgProg = config.programs.parking;
        cfgSrv = config.services.parking;
        pkg = self.packages.${config.nixpkgs.system}.default;
      in {
        ####### CLI program option #########################################################
        options.programs.apcoabot.enable = lib.mkEnableOption "Install parking-confirm CLI tool";

        config.environment.systemPackages = lib.mkIf cfgProg.enable [pkg];

        ####### Systemd service options ###################################################
        options.services.parking = {
          enable = lib.mkEnableOption "Daily parking confirmation service";

          startTime = lib.mkOption {
            type = lib.types.str;
            default = "07:45";
            description = "When to run the confirmation (systemd OnCalendar format)";
          };

          registration = lib.mkOption {
            type = lib.types.str;
            description = "Vehicle registration plate";
          };
        };

        ####### Systemd service + timer ###################################################
        config.systemd = lib.mkIf cfgSrv.enable {
          services.apcoabot = {
            description = "Send daily parking confirmation";
            serviceConfig = {
              ExecStart = "${pkg}/bin/parking-confirm ${cfgSrv.registration}";
            };
          };

          timers.apcoabot = {
            description = "Timer for parking confirmation";
            wantedBy = ["timers.target"];
            timerConfig = {
              OnCalendar = cfgSrv.startTime;
              Persistent = true;
            };
          };
        };
      };
    };
}
