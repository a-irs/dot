ZSHINE_PLUGINS=(
  # dev
  python
  nim
  haskell
  asdf
  elixir

  auto-env  # source .env
  projects

  completion # tweaks for TAB-completion
  keys # bind keys for delete, history-search etc.

  dircolors # colors for "ls" command
  tty-colors # colors for $TERM=linux
  syntax-highlighting # provides a syntax highlighted prompt
  zsh-history-substring-search # arrow key up/down history search

  prompt-git # provides functions for a git-prompt
  term-title # sets terminal/tab title

  fzf # fuzzy-search of files
  cdr # recent dirs command
  zshmarks # set bookmarks
  explain # explain command switches
  aliases # provides some aliases and functions for daily work
  aliases-global # ZSH global aliases
  auto-ls # launch "ls" when entering directory
  nix # nixos, nix package manager
  # kubernetes  # aliases, autocompletion for k8s

  infra # custom
  fasd  # autocomplete paths
  fasd-fzf  # autocomplete paths

  status  # server status on login
  vault  # hashicorp vault

  todo  # show ~/.todo on start
)

for _loadx in $ZSHINE_PLUGINS; do
    source "$ZSHINE_DIR/plugins/$_loadx.zsh"
done
unset _loadx
