function main_menu() {
  editor_options=$1

  while :
  do
    print_main_menu

    user_input="$(get_user_input "Please choose an option: ")"
    if [[ "${user_input}" == "" ]]; then continue; fi

    case $user_input in 
      "E"|"e")
        action_execute "${editor_options}"
        ;;
      "N"|"n")
        action_new
        ;;
      "D"|"d"|"R"|"r")
        action_remove
        ;;
      "L"|"l")
        action_list
        ;;
      "Q"|"q")
        exit 0
        ;;

      *) 
        echo "Unknown option: \"${user_input}\"" 
        ;; 
    esac
  done
}

function print_main_menu() {
  cat <<-EOF
[E]xecute      Execute the editor command with selected configuration
[N]ew          Create a new configuration
[R]emove       Remove existing configuration
[L]ist         List available configurations
[Q]uit         Quit

EOF
}

