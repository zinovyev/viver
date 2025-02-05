# Vivers

## Description

**Viver** is a simple configuratoin manager for Vim and Neovim written in Bash.

Now you can store all your configuration and environment files for a particular setup bundled under one directory.
You can easily create, remove or execute particular configurations whether you want to test something or you just want
to work with a particular set of plugins or settings.

Every setup "knows" what is the editor it should use: Vim or Neovim (which is defined upon generation),
keeps it own history and you can easily create backups of everything before updating the package manager
or just various packages, or just making changes to your $VIMRC file.

## Examples

## TODO

* [ ] Prepare some examples of usage
* [ ] Split config to multiple files
* [ ] Allow usage of command options for shorter syntax
* [ ] Export every configuration to the $PATH so that you can call as a separate command or alias
* [ ] Split source code into modules compiled to a single script to keep it clean
* [ ] Allow usage of multiple versions of Vim/Neovim simultaneously
* [ ] Keep all the environment variables in a separate configuration file
* [ ] Installation script
