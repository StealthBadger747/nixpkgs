# nix-build '<nixpkgs/nixos>' -A config.system.build.cloudstackImage --arg configuration "{ imports = [ ./nixos/maintainers/scripts/cloudstack/cloudstack-image.nix ]; }"

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ../../../modules/virtualisation/cloudstack-config.nix ];

  system.build.cloudstackImage = import ../../../lib/make-disk-image.nix {
    inherit lib config pkgs;
    format = "qcow2";
    configFile = pkgs.writeText "configuration.nix" ''
      {
        imports = [ <nixpkgs/nixos/modules/virtualisation/cloudstack-config.nix> ];
      }
    '';
  };

}
