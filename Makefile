SHEBANG := \#! /usr/bin/env bash

build: init_file header main_menu action_execute action_list action_new \
	action_install action_remove action_debug editor_configuration footer
init_file:
	echo "$(SHEBANG)" > ./viver
header:
	cat ./src/header.sh | sed '/^\s*#/d' >> ./viver
main_menu:
	cat ./src/main_menu.sh | sed '/^\s*#/d' >> ./viver
action_execute:
	cat ./src/action_execute.sh | sed '/^\s*#/d' >> ./viver
action_list:
	cat ./src/action_list.sh | sed '/^\s*#/d' >> ./viver
action_new:
	cat ./src/action_new.sh | sed '/^\s*#/d' >> ./viver
action_install:
	cat ./src/action_install.sh | sed '/^\s*#/d' >> ./viver
action_remove:
	cat ./src/action_remove.sh | sed '/^\s*#/d' >> ./viver
action_debug:
	cat ./src/action_debug.sh | sed '/^\s*#/d' >> ./viver
editor_configuration:
	cat ./src/editor_configuration.sh | sed '/^\s*#/d' >> ./viver
footer:
	cat ./src/footer.sh | sed '/^\s*#/d' >> ./viver
