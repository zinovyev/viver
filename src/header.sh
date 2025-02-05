# /usr/bin/env bash

# Viver is a simple configuratoin manager for Vim and Neovim written in Bash.
# See the usage examples here: https://github.com/zinovyev/viver

# The root dir where all the Vim/Neovim setups will be stored to.
MAIN_CONFIGURATION_PATH="$HOME/.config/viver"

# Vim and Neovim bin paths
VIM_BIN_PATH="/usr/bin/vim"
NVIM_BIN_PATH="/usr/bin/nvim"

# Runtime paths for Vim
#
# Variables:
#
# $VIM - /usr/share/vim
# $VIMRUNTIME - /usr/share/vim/vim91
DEFAULT_VIM_RUNTIME_PATHS=(
  "\\\$VIM/vimfiles"
  "\\\$VIMRUNTIME"
  "\\\$VIM/vimfiles/after"
)

# Runtime paths for Nvim
#
# Variables:
#
# $VIM - /usr/share/vim
# $VIMRUNTIME - /usr/share/vim/runtime
DEFAULT_NVIM_RUNTIME_PATHS=(
  "/usr/local/share/nvim/site"
  "\\\$VIM/site"
  "\\\$VIMRUNTIME"
  "/usr/lib/nvim"
  "\\\$VIM/site/after"
  "/usr/local/share/nvim/site/after"
  "/etc/xdg/nvim/after"
)

function main() {
  editor_options=$1
  declare -A current_config

  print_about
  initialize_viver
  main_menu "${editor_options}"
}

function print_about() {
  cat <<-EOF

Viver is a simple configuratoin manager for Vim and Neovim written in Bash.
See the usage examples here: https://github.com/zinovyev/viver

EOF
}

