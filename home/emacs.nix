{ config, ... }:

let
  # Must be an absolute path *string*, not a relative Nix path (./config/...).
  # A relative Nix path gets interned into the store at eval time, which would
  # make the symlink point at a frozen store copy instead of the live repo
  # file, silently breaking "edit and reload" workflows.
  emacsConfigDir = "${config.home.homeDirectory}/nixos/home/config/emacs";
in
{
  # Auto-start an Emacs daemon with the graphical session (GNOME) so
  # `emacsclient` always has a server to attach to, without a manual
  # `M-x server-start` after every reboot.
  services.emacs = {
    enable = true;
    startWithUserSession = "graphical";
  };

  # Emacs config lives here in the repo and is symlinked into ~/.emacs.d so
  # it's tracked in git. secrets.el, the tangled emacs.el, and caches
  # (elpa, eln-cache, etc.) stay untracked local files - see
  # ~/.emacs.d/.gitignore.
  home.file = {
    ".emacs.d/emacs.org".source = config.lib.file.mkOutOfStoreSymlink "${emacsConfigDir}/emacs.org";
    ".emacs.d/early-init.el".source = config.lib.file.mkOutOfStoreSymlink "${emacsConfigDir}/early-init.el";
    ".emacs.d/init.el".source = config.lib.file.mkOutOfStoreSymlink "${emacsConfigDir}/init.el";
    ".emacs.d/custom-vars.el".source = config.lib.file.mkOutOfStoreSymlink "${emacsConfigDir}/custom-vars.el";
    ".emacs.d/scripts/buffer-move.el".source = config.lib.file.mkOutOfStoreSymlink "${emacsConfigDir}/scripts/buffer-move.el";
  };
}
