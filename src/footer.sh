# Make sure the file exists. Create an empty one if not.
function ensure_file_exists() {
  if [[ "$1" == "" ]]; then raise_error "File path is not defined!"; fi
  if [ ! -e "$1" ]; then
    install -D <(echo $2) $1
  fi
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
