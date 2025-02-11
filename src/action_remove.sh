# Remove particular configuration by name
function action_remove() {
  echo "Remove configuration"

  while :
  do
    list_configurations
    config_name="$(get_user_input "Please choose a name to remove (or [Q] to go back): ")"
    if [[ "${config_name}" == "" ]]; then continue; fi
    if [[ "${config_name}" == "Q" ]] || [[ "${config_name}" == "q" ]]; then return; fi

    parse_config "${config_name}"

    if [[ ! "${current_config[name]}" == "" ]]; then
      remove_configuration_menu

      break
    fi
  done
}

function remove_configuration_menu() {
  print_configuration_menu

  editor_name=
  while :
  do
    user_input="$(get_user_input "Are you sure you want to remove \"${current_config[name]}\": ")"
    if [[ "${user_input}" == "" ]]; then continue; fi

    case $user_input in 
      "Y"|"y")
        echo "Removing \"${current_config[name]}\"...\n"
        rm -rf "${current_config[full_path]}"
        rm "${current_config[shim_path]}"

        break
        ;;
      "N"|"n")
        return
        ;;

      *) 
        echo "Unknown command: \"${user_input}\"" 
        ;; 
    esac
  done
}

function print_configuration_menu() {
  cat <<-EOF

[Y]es          To proceed
[N]o           To cancel

EOF
}
