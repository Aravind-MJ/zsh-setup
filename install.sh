#!/usr/bin/env bash
set -euo pipefail

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.zsh-setup-backups/$(date +%Y%m%d-%H%M%S)"
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

log() {
  printf '\033[1;36m==>\033[0m %s\n' "$1"
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1
}

clone_or_update() {
  local repo="$1"
  local dest="$2"
  if [ -d "$dest/.git" ]; then
    log "Updating $(basename "$dest")"
    git -C "$dest" pull --ff-only >/dev/null
  else
    log "Installing $(basename "$dest")"
    git clone --depth=1 "$repo" "$dest" >/dev/null
  fi
}

if ! need_cmd git; then
  printf 'git is required. Install git first.\n' >&2
  exit 1
fi

if ! need_cmd curl; then
  printf 'curl is required for Oh My Zsh installation. Install curl first.\n' >&2
  exit 1
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  log "Installing Oh My Zsh"
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if need_cmd cargo; then
  need_cmd starship || cargo install starship --locked
  need_cmd eza || cargo install eza
  need_cmd bat || cargo install bat
  need_cmd zoxide || cargo install zoxide --locked
else
  log "cargo not found; skipping starship/eza/bat/zoxide install. Install them manually if missing."
fi

if ! need_cmd fzf; then
  log "Installing fzf"
  if [ -d "$HOME/.fzf/.git" ]; then
    git -C "$HOME/.fzf" pull --ff-only >/dev/null
  else
    git clone --depth=1 https://github.com/junegunn/fzf.git "$HOME/.fzf" >/dev/null
  fi
  "$HOME/.fzf/install" --bin --key-bindings --completion --no-update-rc >/dev/null
fi

if ! need_cmd direnv; then
  log "direnv not found; install it with your system package manager for the direnv plugin."
fi

mkdir -p "$ZSH_CUSTOM_DIR/plugins" "$ZSH_CUSTOM_DIR/themes" "$HOME/.config" "$BACKUP_DIR"

[ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$BACKUP_DIR/.zshrc"
[ -f "$HOME/.fzf.zsh" ] && cp "$HOME/.fzf.zsh" "$BACKUP_DIR/.fzf.zsh"
[ -f "$HOME/.config/starship.toml" ] && cp "$HOME/.config/starship.toml" "$BACKUP_DIR/starship.toml"

clone_or_update https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$ZSH_CUSTOM_DIR/plugins/fast-syntax-highlighting"
clone_or_update https://github.com/Aloxaf/fzf-tab.git "$ZSH_CUSTOM_DIR/plugins/fzf-tab"
clone_or_update https://github.com/wfxr/forgit.git "$ZSH_CUSTOM_DIR/plugins/forgit"
clone_or_update https://github.com/MichaelAquilina/zsh-you-should-use.git "$ZSH_CUSTOM_DIR/plugins/zsh-you-should-use"
clone_or_update https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"
clone_or_update https://github.com/zsh-users/zsh-history-substring-search.git "$ZSH_CUSTOM_DIR/plugins/zsh-history-substring-search"
clone_or_update https://github.com/zsh-users/zsh-completions.git "$ZSH_CUSTOM_DIR/plugins/zsh-completions"
clone_or_update https://github.com/olets/zsh-abbr.git "$ZSH_CUSTOM_DIR/plugins/zsh-abbr"
git -C "$ZSH_CUSTOM_DIR/plugins/zsh-abbr" submodule update --init --recursive >/dev/null
clone_or_update https://github.com/fdellwing/zsh-bat.git "$ZSH_CUSTOM_DIR/plugins/zsh-bat"
clone_or_update https://github.com/loiccoyle/zsh-github-copilot.git "$ZSH_CUSTOM_DIR/plugins/zsh-github-copilot"

cp "$SETUP_DIR/starship-cockpit.zsh-theme" "$ZSH_CUSTOM_DIR/themes/starship-cockpit.zsh-theme"
cp "$SETUP_DIR/starship.toml" "$HOME/.config/starship.toml"
cp "$SETUP_DIR/fzf.zsh" "$HOME/.fzf.zsh"
cp "$SETUP_DIR/zshrc.template" "$HOME/.zshrc"

cat > "$BACKUP_DIR/RESTORE_COMMAND.txt" <<EOF
cp "$BACKUP_DIR/.zshrc" "$HOME/.zshrc"
[ -f "$BACKUP_DIR/.fzf.zsh" ] && cp "$BACKUP_DIR/.fzf.zsh" "$HOME/.fzf.zsh"
[ -f "$BACKUP_DIR/starship.toml" ] && cp "$BACKUP_DIR/starship.toml" "$HOME/.config/starship.toml"
EOF

log "Installed cockpit zsh setup"
log "Backup: $BACKUP_DIR"
log "Open a new shell or run: source ~/.zshrc"
