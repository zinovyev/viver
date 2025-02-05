function action_new() {
  select_editor_menu

  # Choosing the configuration name
  config_name=
  config_path=
  while :
  do
    config_name="$(get_user_input "Please set the config name: ")"
    if [[ "${config_name}" == "" ]]; then continue; fi

    config_path="${MAIN_CONFIGURATION_PATH}/${config_name}"
    break
  done

  # Choosing an editor
  ensure_file_exists "${config_path}/.editor" $editor_name
  ensure_file_exists "${config_path}/init.vim"
  ensure_file_exists "${config_path}/.viminfo"
}

function select_editor_menu() {
  print_select_editor_menu

  editor_name=
  while :
  do
    user_input="$(get_user_input "Please choose an editor: ")"
    if [[ "${user_input}" == "" ]]; then continue; fi

    case $user_input in 
      "V"|"v")
        editor_name="vim"
        break
        ;;
      "N"|"n")
        editor_name="nvim"
        break
        ;;
      "Q"|"q")
        return
        ;;

      *) 
        echo "Unknown editor: \"${user_input}\"" 
        ;; 
    esac
  done
}

function print_select_editor_menu() {
  cat <<-EOF

[V]im          ${VIM_BIN_PATH}
[N]eovim       ${NVIM_BIN_PATH}
[Q]uit         To go back

EOF
}
