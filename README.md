# Zsh Setup

Portable Oh My Zsh setup with the [Headline](https://gist.github.com/Aravind-MJ/46d7711fa124227249aaf8540ed1d5f6) prompt, `fzf-tab`, syntax highlighting, autosuggestions, `eza`, `bat`, `zoxide`, and `direnv`.

The goal is a dramatic terminal experience that is still reproducible across machines.

## Quick Install

```sh
git clone git@github.com:Aravind-MJ/zsh-setup.git
cd zsh-setup
./install.sh
```

Open a new terminal, or reload manually:

```sh
source ~/.zshrc
```

## Agent Install Prompt

Give an agent this instruction on a new machine:

```text
Install my zsh setup from git@github.com:Aravind-MJ/zsh-setup.git. Clone it, run ./install.sh, preserve any machine-specific secrets by putting them in ~/.zshrc.local, and verify zsh starts cleanly.
```

## What Gets Installed

The installer applies a portable `.zshrc`, the Headline Oh My Zsh theme, and fzf integration.

Community plugins:

- `fast-syntax-highlighting`
- `fzf-tab`
- `forgit`
- `zsh-you-should-use`
- `zsh-autosuggestions`
- `zsh-history-substring-search`
- `zsh-completions`
- `zsh-abbr`
- `zsh-bat`
- `zsh-github-copilot`

Oh My Zsh built-ins enabled:

- `git`
- `command-not-found`
- `zoxide`
- `direnv`
- `eza`
- `colored-man-pages`
- `extract`
- `bgnotify`

CLI tools installed via Cargo when available:

- `eza`
- `bat`
- `zoxide`

`fzf` is installed from upstream GitHub if missing.

## Requirements

- `zsh`
- `git`
- `curl`
- A Nerd Font for icons
- Optional but recommended: Rust/Cargo for local binary installs

If `cargo` is missing, install `eza`, `bat`, and `zoxide` with your package manager before or after running the installer.

`direnv` is not installed automatically because it is best installed through the system package manager.

## Files

- `install.sh`: installs tools/plugins, backs up existing config, applies setup
- `zshrc.template`: portable `.zshrc`
- `headline.zsh-theme`: Headline prompt (from the gist above)
- `fzf.zsh`: fzf keybindings without conflicting with `fzf-tab`

## Customization

Machine-specific settings should go here:

```sh
~/.zshrc.local
```

Use it for secrets, work aliases, PATH entries, NVM/Pyenv setup, project exports, and host-specific tooling.

Prompt styling lives in the Headline theme. Oh My Zsh selects it here:

```sh
~/.oh-my-zsh/custom/themes/headline.zsh-theme
```

If you edit variables in `~/.zshrc`, source the theme first, then set the Headline `HL_*` variables.

## Backup And Revert

The installer backs up existing files to:

```sh
~/.zsh-setup-backups/<timestamp>/
```

Each backup includes:

```sh
RESTORE_COMMAND.txt
```

To revert, open that file and run the listed commands.

## Notes

- The setup intentionally avoids storing secrets or work-specific exports.
- The `.zshrc` sources `~/.zshrc.local` if it exists.
- `fzf-tab` owns Tab completion; fzf's default Tab completion is intentionally disabled to avoid conflicts.
- `zsh-bat` aliases `cat` to `bat`; use `rcat` for the real `cat`.
- The `eza` plugin aliases `ls`, `ll`, and related listing commands.
