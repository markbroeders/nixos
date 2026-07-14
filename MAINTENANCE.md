# System Maintenance Cheat Sheet

Config lives at `/home/mark/nixos`, hostname `wheeler`. Home-manager runs as a
NixOS module, so `nixos-rebuild` deploys both system and user (home)
configuration together — there is no separate `home-manager switch` step.

## Editing & applying config

```bash
cd /home/mark/nixos

# Edit files, then apply changes:
sudo nixos-rebuild switch --flake .#wheeler

# Build only, don't activate (sanity check it compiles):
sudo nixos-rebuild build --flake .#wheeler

# Apply but only activate on next boot (safer for risky changes):
sudo nixos-rebuild boot --flake .#wheeler

# Try a config in a throwaway VM without touching your real system:
sudo nixos-rebuild build-vm --flake .#wheeler
```

## Updating packages

```bash
# Update every flake input (nixpkgs, home-manager, claude-code-nix) and
# write the new versions to flake.lock:
nix flake update

# Update just one input, e.g. only nixpkgs:
nix flake lock --update-input nixpkgs

# See what changed before committing to it:
nix flake metadata

# After updating the lock file, rebuild to actually pull in the new packages:
sudo nixos-rebuild switch --flake .#wheeler
```

Commit `flake.lock` after updating so the change is tracked and revertible:
```bash
git add flake.lock
git commit -m "Update flake inputs"
```

## Rolling back

```bash
# List available generations:
sudo nixos-rebuild list-generations

# Roll back to the previous generation immediately:
sudo nixos-rebuild switch --rollback

# Or pick a specific generation at boot time from the systemd-boot menu
# (it lists every generation automatically).
```

## Cleaning up / freeing disk space

Auto-GC is enabled (`modules/system.nix`): every week the system deletes
generations older than 14 days and runs store optimisation automatically —
you normally don't need to do this by hand. Check when it last ran and
trigger it manually if you want space back sooner:

```bash
# Check the timer's status / last run:
systemctl status nix-gc.service
systemctl list-timers nix-gc.timer

# Trigger it manually right now instead of waiting for the weekly timer:
sudo systemctl start nix-gc.service

# Remove old generations older than a custom cutoff (one-off, e.g. tighter than 14d):
sudo nix-collect-garbage --delete-older-than 7d

# Nuke everything except the current generation (aggressive):
sudo nix-collect-garbage -d

# Also expire old home-manager generations specifically:
home-manager expire-generations "-14 days"

# See how much space the store is using:
du -sh /nix/store
```

Since boot entries pile up in systemd-boot until GC removes their
generations, the weekly auto-GC also keeps the boot menu tidy on its own.

## Inspecting state

```bash
# What generation are you on, and when was each created:
nix-env --list-generations --profile /nix/var/nix/profiles/system

# Diff what a rebuild would change before applying it:
nixos-rebuild dry-activate --flake .#wheeler

# Check config for eval errors without building:
nix flake check
```

## Searching for packages

```bash
# Search nixpkgs from the CLI:
nix search nixpkgs <name>

# Or use https://search.nixos.org/packages
```

Add a package by editing `modules/packages.nix` (system-wide) or
`home/*.nix` (user-scoped via home-manager), then `sudo nixos-rebuild switch
--flake .#wheeler`.
