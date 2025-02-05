function action_execute() {
  editor_options=$1

  echo "Execute the editor command"

  while :
  do
    list_configurations

    config_name="$(get_user_input "Please choose a name to execute (or [Q] to go back): ")"
    if [[ "${config_name}" == "" ]]; then continue; fi
    if [[ "${config_name}" == "Q" ]] || [[ "${config_name}" == "q" ]]; then return; fi

    config_path="${MAIN_CONFIGURATION_PATH}/${config_name}"
    parse_config $config_path

    if [[ ! "${current_config[name]}" == "" ]]; then
      print_config 

      cmd="$(build_command ${current_config[editor]} "${editor_options}" ${current_config[name]})"

      bash -c "${cmd}"

      break
    fi
  done
}
