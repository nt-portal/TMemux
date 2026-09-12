#!/usr/bin/env bash
# LazyVim-Termux — replaces NvChad flow
# source: https://github.com/nt-portal/LazyVim-Termux.git (install.sh)
# font default: assest/font.ttf -> ~/.termux/font.ttf

function NvChad() {
  echo -e "\n‏‏‎‏‏‎ ‎ ‎‏‏‎  ‎📦 Installing Neovim (LazyVim-Termux)\n"
  stat "CHECK" "Warning" "'${COLOR_WARNING}LazyVim${COLOR_BASED}' Starter"

  # deps needed by LazyVim-Termux install.sh + DeepSeek
  for _pkg in git neovim nodejs yarn fd grep; do
    if ! pkg list-installed $_pkg 2>/dev/null | grep -q "^$_pkg/"; then
      start_animation "       Installing '${COLOR_SUCCESS}$_pkg${COLOR_BASED}' ..."
      pkg i -y $_pkg &>/dev/null
      stop_animation $?
    fi
  done

  # backup old nvim dirs (same as upstream: mv {,.bak})
  for _d in ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim; do
    if [ -e "$_d" ] && [ ! -e "${_d}.bak" ]; then
      stat "RUN" "Warning" "Backup '${COLOR_WARNING}$_d${COLOR_BASED}' -> '${COLOR_WARNING}${_d}.bak${COLOR_BASED}'"
      mv "$_d" "${_d}.bak" 2>/dev/null
      stat "RESULT" "Success" "Backup done"
    elif [ -e "$_d" ]; then
      _ts=$(date +%Y.%m.%d-%H.%M.%S)
      stat "RUN" "Warning" "Backup '${COLOR_WARNING}$_d${COLOR_BASED}' -> '${COLOR_WARNING}${_d}.${_ts}.bak${COLOR_BASED}'"
      mv "$_d" "${_d}.${_ts}.bak" 2>/dev/null
      stat "RESULT" "Success" "Backup done"
    fi
  done

  # clone LazyVim starter
  if [ -d "$HOME/.config/nvim" ]; then
    stat "RESULT" "Warning" "'${COLOR_WARNING}.config/nvim${COLOR_BASED}' already exists, skip clone"
  else
    start_animation "       Cloning '${COLOR_SUCCESS}LazyVim/starter${COLOR_BASED}' ..."
    git clone https://github.com/LazyVim/starter ~/.config/nvim 2>/dev/null
    if [ -d "$HOME/.config/nvim" ]; then
      rm -rf ~/.config/nvim/.git
      stop_animation 0
    else
      stop_animation 1
      stat "RESULT" "Danger" "Clone failed"
      return 1
    fi
  fi

  PLUGINS="$HOME/.config/nvim/lua/plugins"
  mkdir -p "$PLUGINS"

  # plugins — exact from nt-portal/LazyVim-Termux install.sh
  cat >"$PLUGINS/wakatime.lua" <<'EOF'
return {
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },
}
EOF

  cat >"$PLUGINS/noice-disable.lua" <<'EOF'
return {
  {
    "folke/noice.nvim",
    enabled = false,
  },
  {
    "rcarriga/nvim-notify",
    enabled = false,
  },
}
EOF

  cat >"$PLUGINS/markview.lua" <<'EOF'
return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("markview").setup()
    end,
  },
}
EOF

  cat >"$PLUGINS/transparent.lua" <<'EOF'
return {
  "xiyaowong/transparent.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("transparent").setup({
      extra_groups = {
        "NormalFloat",
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "Dashboard",
      },
    })
    vim.g.transparent_enabled = true
  end,
}
EOF

  cat >"$PLUGINS/markmap.lua" <<'EOF'
return {
  {
    "Zeioth/markmap.nvim",
    build = "yarn global add markmap-cli",
    cmd = {
      "MarkmapOpen",
      "MarkmapSave",
      "MarkmapWatch",
      "MarkmapWatchStop",
    },
  },
}
EOF

  # upstream has stray `}` — fixed here
  cat >"$PLUGINS/error-lens.lua" <<'EOF'
return {
  "chikko80/error-lens.nvim",
  event = "LspAttach",
  opts = {},
}
EOF

  # font default: assest/font.ttf -> ~/.termux/font.ttf (repo's .termux/font.ttf is the source)
  stat "RUN" "Warning" "Installing font '${COLOR_WARNING}assest/font.ttf${COLOR_BASED}' -> '${COLOR_WARNING}~/.termux/font.ttf${COLOR_BASED}'"
  mkdir -p "$HOME/.termux"
  # prefer repo-bundled font, fallback to curl
  if [ -f "$(pwd)/.termux/font.ttf" ]; then
    cp "$(pwd)/.termux/font.ttf" "$HOME/.termux/font.ttf" 2>/dev/null
  elif [ -f "$(pwd)/assest/font.ttf" ]; then
    cp "$(pwd)/assest/font.ttf" "$HOME/.termux/font.ttf" 2>/dev/null
  else
    curl -fL -o "$HOME/.termux/font.ttf" "https://github.com/nt-portal/LazyVim-Termux/raw/main/assest/font.ttf" 2>/dev/null
  fi
  if [ -f "$HOME/.termux/font.ttf" ]; then
    termux-reload-settings 2>/dev/null
    stat "RESULT" "Success" "Font installed"
  else
    stat "RESULT" "Danger" "Font install failed"
  fi

  stat "RESULT" "Success" "'${COLOR_SUCCESS}LazyVim${COLOR_BASED}' ready — run '${COLOR_SUCCESS}nvim${COLOR_BASED}'"
}
