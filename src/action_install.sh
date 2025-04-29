# Initialize a new setup based on the github repository
function action_install() {
  # Choosing the configuration name
  config_name=
  config_path=
  while :
  do
    config_name="$(get_user_input "Please set the config name: ")"
    if [[ "${config_name}" == "" ]]; then continue; fi

    config_path="${SETUPS_PATH}/${config_name}"

    if [[ -e "$config_path" ]]; then
      echo "Path \"${config_path}\" already exists. Try another name"
      continue
    fi

    break
  done

  # Choosing the GH path
  config_source=
  while :
  do
    config_source="$(get_user_input "Please specify a git source location (https://github.com/<user>/<repo>.git): ")"
    if [[ "${config_source}" == "" ]]; then continue; fi

    break
  done

  # Cloning the repository
  git clone "${config_source}" "${config_path}"
  if [[ $? -ne 0 ]]; then
    raise_error "Couldn't clone the repository \"${config_source}\" to ${config_path}"
  fi

  # Building a shim
  parse_config "${config_name}"
  cmd="$(build_command "\$@")"

  echo $cmd > "${current_config[shim_path]}"
  chmod +x "${current_config[shim_path]}"
}
