# Zsh Cockpit Setup

Portable Oh My Zsh setup with Starship, fzf-tab, syntax highlighting, autosuggestions, eza, bat, zoxide, direnv, and a custom cockpit prompt.

## Use From A Gist

Give an agent this instruction:

```text
Install my zsh setup from this gist: <GIST_URL>. Download the files into a temporary zsh-setup folder and run install.sh. Do not copy secrets or machine-specific aliases into the gist setup.
```

Manual install after downloading/cloning the gist:

```sh
chmod +x install.sh
./install.sh
```

## Files

- `install.sh`: installs tools/plugins, backs up existing config, applies setup
- `zshrc.template`: portable `.zshrc`
- `starship.toml`: cockpit prompt configuration
- `starship-cockpit.zsh-theme`: Oh My Zsh theme wrapper for Starship
- `fzf.zsh`: fzf keybindings without conflicting with `fzf-tab`

## Backup And Revert

The installer backs up existing files to:

```sh
~/.zsh-setup-backups/<timestamp>/
```

Each backup includes `RESTORE_COMMAND.txt`.

## Notes

- Requires a Nerd Font for icons and powerline separators.
- If `cargo` is available, the installer installs `starship`, `eza`, and `bat` locally.
- If `cargo` is missing, install `starship`, `eza`, and `bat` with your package manager first.
- Put machine-specific aliases, secrets, NVM/Pyenv paths, work aliases, and project exports in `~/.zshrc.local`.
