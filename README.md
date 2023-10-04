# About
This is my personal nixos configuration using [flakes](https://nixos-and-flakes.thiscute.world/nixos-with-flakes/get-started-with-nixos). As always, this is an ongoing work-in-progess.

# Installation
- [ ] Todo


# Useful commands
```
# Load configuration changes
sudo nixos-rebuild switch --flake [DIR]#[HOSTNAME]

# Delete all historical versions older than 7 days
sudo nix profile wipe-history --older-than 7d --profile /nix/var/nix/profiles/system

# Run garbage collection after wiping history
sudo nix store gc --debug
```


