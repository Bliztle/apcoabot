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
        cfgProg = config.programs.apcoabot;
        cfgSrv = config.services.apcoabot;
        pkg = self.packages.${config.nixpkgs.system}.default;
      in {
        options = {
          ####### CLI program option #########################################################
          programs.apcoabot.enable = lib.mkEnableOption "Install the apcoabot cli";

          ####### Systemd service options ###################################################
          services.apcoabot = {
            enable = lib.mkEnableOption "Daily parking confirmation service";

            startTime = lib.mkOption {
              type = lib.types.str;
              default = "07:45";
              description = "When to run the confirmation (systemd OnCalendar format)";
            };

            registration = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Vehicle registration plate";
            };

            phoneNumber = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Phone number for confirmation SMS";
            };

            configFile = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Configuration file containing apcoabot options. Explicit options take priority.";
            };
          };
        };
        config = {
          environment.systemPackages = lib.mkIf cfgProg.enable [pkg];

          ####### Assertions ###############################################################
          assertions = lib.mkIf cfgSrv.enable [
            {
              assertion =
                cfgSrv.configFile
                != null
                || (cfgSrv.registration != null && cfgSrv.phoneNumber != null);
              message = ''
                apcoabot: You must set either:
                  • services.apcoabot.configFile
                  OR
                  • services.apcoabot.registration AND services.apcoabot.phoneNumber
              '';
            }
          ];

          ####### Systemd service + timer ###################################################
          systemd = lib.mkIf cfgSrv.enable {
            services.apcoabot = {
              description = "Send daily parking confirmation";

              serviceConfig = {
                ExecStart = ''
                  ${pkg}/bin/apcoabot \
                    ${lib.optionalString (cfgSrv.configFile != null) "--config ${cfgSrv.configFile}"} \
                    ${lib.optionalString (cfgSrv.registration != null) "-r ${cfgSrv.registration}"} \
                    ${lib.optionalString (cfgSrv.phoneNumber != null) "-p ${cfgSrv.phoneNumber}"}
                '';
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
    };
}
