# Project templates

Flake templates for scaffolding new projects, kept alongside the system
config so they update together. Each template lives in its own directory
under `templates/` and is registered in the root `flake.nix` under
`templates.<name>`.

## python

A per-project Python dev shell: a Nix flake provides the interpreter
(`python312` + `pip` + `virtualenv`), and `direnv` manages a `.venv` for
pip-installed packages. Nothing is added to the system config — each
project is self-contained.

**New project setup:**

```bash
cd /path/to/your/project
nix flake init -t /home/mark/nixos#python
direnv allow
```

`direnv allow` triggers `.envrc`, which loads the flake's devShell
(`use flake`) and then creates/activates `.venv` (`layout python3`) using
the interpreter the devShell provides.

**Installing dependencies:** list them in `requirements.txt`, then:

```bash
pip install -r requirements.txt
```

This runs inside the direnv-managed `.venv`, so it's isolated per project.
Pure-Python packages install fine this way. Packages needing compiled
binary wheels can break on NixOS (no standard FHS paths) — if that
happens, either look for the package in nixpkgs and add it to
`flake.nix`'s `packages` list instead of `requirements.txt`, or ask about
`nix-ld` as a workaround.

**Day to day:** just `cd` into the project directory — direnv activates
the shell and venv automatically. No `nix develop` or manual `source
.venv/bin/activate` needed.

**Updating the Python version or adding system-level Nix packages:** edit
that project's own `flake.nix` (not this repo's), e.g. swap `python312`
for a different version, or add packages like `postgresql` if the project
needs a local service.

## Adding a new template

1. Create `templates/<name>/` with the files a new project should start
   with.
2. Register it in the root `flake.nix`:
   ```nix
   templates.<name> = {
     path = ./templates/<name>;
     description = "...";
   };
   ```
3. Scaffold with `nix flake init -t /home/mark/nixos#<name>`.
