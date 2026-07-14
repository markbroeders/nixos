run pip install -r requirements.txt once — all of these are pure-Python packages so plain pip works fine, no compiled-wheel issues to worry about on NixOS.
# How to use the devshell
cd /path/to/your/project
nix flake init -t /home/mark/nixos#python
direnv allow
That creates a nix devShell (providing the Python interpreter) and a .venv that direnv auto-activates on cd.
