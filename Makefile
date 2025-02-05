build: init_file header main_menu action_execute action_list action_new action_remove footer
init_file:
	> ./viver
header:
	cat ./src/header.sh >> ./viver
main_menu:
	cat ./src/main_menu.sh >> ./viver
action_execute:
	cat ./src/action_execute.sh >> ./viver
action_list:
	cat ./src/action_list.sh >> ./viver
action_new:
	cat ./src/action_new.sh >> ./viver
action_remove:
	cat ./src/action_remove.sh >> ./viver
footer:
	cat ./src/footer.sh >> ./viver
