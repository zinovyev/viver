# List all known setups
function action_list() {
  echo -e "\nKnown configurations:\n"

  list_configurations

  echo
  get_user_input
}
