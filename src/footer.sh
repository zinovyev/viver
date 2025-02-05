# Build vim/nvim command path
function build_command() {
  editor_name=$1
  editor_options=$2
  config_name=$3
  editor_bin_path=

  # Setting the editor path and the config path
  case $editor_name in 
    "vim")
      editor_bin_path="${VIM_BIN_PATH}"
      ;;
    "nvim")
      editor_bin_path="${NVIM_BIN_PATH}"
      ;;
    *) raise_error "Invalid "${editor_bin_path}" editor name \"${1}\"" ;; 
  esac

  # Compile the full command line
  cmd="${editor_bin_path} ${editor_options}"
  if [[ ! "$config_name" == "" ]]; then
    config_path="${MAIN_CONFIGURATION_PATH}/${config_name}"
    runtime_path=$(build_runtime_path "${editor_name}" "${config_path}")
    ensure_file_exists "${config_path}/init.vim"
    ensure_file_exists "${config_path}/.viminfo"
    runtime_path_cmd="--cmd \"set nocp\" "
    runtime_path_cmd+="--cmd \"set runtimepath=${runtime_path}\" "
    runtime_path_cmd+="--cmd \"set packpath=${runtime_path}\" "
    runtime_path_cmd+="--cmd \"set viminfofile=${config_path}/.viminfofile\""

    cmd="export MYVIMRC=${config_path}/init.vim ; ${cmd} -u ${config_path}/init.vim ${runtime_path_cmd}"
  fi

  echo $cmd
}

function list_configurations() {
  configurations=($(find $MAIN_CONFIGURATION_PATH -mindepth 1 -maxdepth 1 -type d))

  for idx in ${!configurations[@]}; do
    parse_config ${configurations[$idx]}
    print_config
  done
}

function print_config() {
  echo
  for i in "${!current_config[@]}"
  do
    echo "${i}: ${current_config[$i]}"
  done
  echo
}

function parse_config() {
  config_path=$1
  current_config[full_path]=$config_path
  current_config[name]=$(basename $config_path)
  current_config[editor]=$(cat "${config_path}/.editor")
  current_config[init_path]="${config_path}/init.vim"
  current_config[viminfo_path]="${config_path}/.viminfo"
  current_config[runtime_path]=$(build_runtime_path ${current_config[editor]} $config_path)
}

# Build the list of paths for the runtime dirs based on the editor name
function build_runtime_path() {
  editor_name=$1
  config_path=$2

  default_runtime_paths=""
  case $editor_name in 
    "vim")
      default_runtime_paths=$(IFS=,; printf %s "${DEFAULT_VIM_RUNTIME_PATHS[*]}")
      ;;
    "nvim")
      default_runtime_paths=$(IFS=,; printf %s "${DEFAULT_NVIM_RUNTIME_PATHS[*]}")
      ;;
    *) raise_error "Invalid editor name \"${editor_name}\"" ;; 
  esac


  echo "${config_path},${default_runtime_paths},${config_path}/after"
}

function ensure_file_exists() {
  if [[ "$1" == "" ]]; then raise_error "File path is not defined!"; fi
  if [ ! -e "$1" ]; then
    install -D <(echo $2) $1
  fi
}
 
function initialize_viver() {
  mkdir -p  $MAIN_CONFIGURATION_PATH
}

# Raise an error and shutdown immediately
function raise_error() {
  echo $1

  kill -15 "$$"
}

function get_user_input() {
  prompt=$1

  read -p "${prompt}" input

  echo $input
}

main $@
