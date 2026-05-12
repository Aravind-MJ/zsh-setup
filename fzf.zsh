# Setup fzf keybindings without overriding fzf-tab's Tab completion.
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh | sed '/^### completion\.zsh ###$/,$d; /eval \$__fzf_key_bindings_options/d')
  setopt aliases
fi
