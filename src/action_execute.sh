# Run a particular vim setup
function action_execute() {
  editor_options=$1

  echo "Execute the editor command"

  while :
  do
    list_configurations

    config_name="$(get_user_input "Please choose a name to execute (or [Q] to go back): ")"
    if [[ "${config_name}" == "" ]]; then continue; fi
    if [[ "${config_name}" == "Q" ]] || [[ "${config_name}" == "q" ]]; then return; fi

    parse_config "${config_name}"

    if [[ ! "${current_config[name]}" == "" ]]; then
      print_config 

      cmd="$(build_command "${editor_options}")"

      bash -c "${cmd}"

      break
    fi
  done
}
