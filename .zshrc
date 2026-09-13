export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="kali"  # TMemux default — Kali style 2-baris: ┌──(user㉿host)-[path]
# ponytail: filter plugins yang belum ter-clone biar tidak error "plugin not found"
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  bgnotify
  zsh-fzf-history-search
  zsh-autocomplete
)
# hanya aktifkan plugin yang ada di disk
_tmp_plugins=()
for _p in "${plugins[@]}"; do
  [[ -d $ZSH/plugins/$_p || -d $ZSH/custom/plugins/$_p ]] && _tmp_plugins+=($_p)
done
plugins=("${_tmp_plugins[@]}")
unset _p _tmp_plugins

PATH="$PREFIX/bin:$HOME/.local/bin:$PATH"
export PATH

LINK="https://github.com/nt-portal"
export LINK

LINK_SSH="git@github.com:nt-portal"
export LINK_SSH

export TERM=xterm-256color

# guard source — jangan error kalau file belum ter-install
[[ -f $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh
[[ -f $HOME/.config/lf/icons ]] && source $HOME/.config/lf/icons

# zstyle autocomplete — menyesuaikan (Kali vibe: menu, warna, fuzzy)
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' rehash true
# autosuggestions (jika plugin ada)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# autocomplete: Tab → menu, ↓↑ navigate, Enter pilih
bindkey '^I' expand-or-complete 2>/dev/null || true

[[ -f $HOME/.aliases ]] && source $HOME/.aliases
[[ -f $HOME/.autostart ]] && source $HOME/.autostart
