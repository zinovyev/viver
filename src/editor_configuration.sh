#
# Everything related to the setup configuration goes here
#

# List known setups
function list_configurations() {
  configurations=($(find $SETUPS_PATH -mindepth 1 -maxdepth 1 -type d))

  for idx in ${!configurations[@]}; do
    config_name=$(basename "${configurations[$idx]}")
    parse_config "${config_name}"
    print_config
  done
}

# Print all known fields for the currently selected configuration setup
function print_config() {
  echo
  for i in "${!current_config[@]}"
  do
    echo "${i}: ${current_config[$i]}"
  done
  echo
}

# Parse configuration with the given path
function parse_config() {
  config_name=$1
  config_path="${SETUPS_PATH}/${config_name}"
  editor_name=$(cat "${config_path}/.editor")

  current_config[full_path]=$config_path
  current_config[name]=$(basename $config_path)
  current_config[editor]=$editor_name
  current_config[init_path]="${config_path}/init.vim"
  current_config[viminfo_path]="${config_path}/.viminfofile"
  current_config[runtime_path]=$(build_runtime_path $editor_name $config_path)
  current_config[bin_path]=$(choose_editor_bin_path $editor_name)
  current_config[shim_path]="${SHIMS_PATH}/${config_name}"
}

# Build vim/nvim command path
function build_command() {
  editor_options=$1

  # Compile the full command line
  cmd="${current_config[bin_path]} ${editor_options}"
  ensure_file_exists "${current_config[init_path]}"
  # ensure_file_exists "${current_config[viminfo_path]}"
  runtime_path_cmd="--cmd \"set nocp\" "
  runtime_path_cmd+="--cmd \"set runtimepath=${current_config[runtime_path]}\" "
  runtime_path_cmd+="--cmd \"set packpath=${current_config[runtime_path]}\" "
  runtime_path_cmd+="--cmd \"set viminfofile=${current_config[viminfo_path]}\""

  echo "export MYVIMRC=${current_config[init_path]} ; ${cmd} -u ${current_config[init_path]} ${runtime_path_cmd}"
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

# Choose editor bin path based on the name
function choose_editor_bin_path() {
  editor_name=$1

  case $editor_name in 
    "vim")
      editor_bin_path="${VIM_BIN_PATH}"
      ;;
    "nvim")
      editor_bin_path="${NVIM_BIN_PATH}"
      ;;
    *) raise_error "Invalid "${editor_bin_path}" editor name \"${1}\"" ;; 
  esac

  echo "$editor_bin_path"
}
