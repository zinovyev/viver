# Viver

## Overview

**Viver** is a lightweight configuration manager for Vim and Neovim, written in Bash. It enables you to maintain multiple, isolated setups effortlessly.

With Viver, you can:

- Bundle configuration and environment files separately for different setups.
- Create, remove, or execute configurations easily.
- Work with distinct sets of plugins or settings without interference.

Unlike simply switching between `.vimrc` files, Viver also isolates runtime files and history, allowing for:

- **Safe Updates**: Backup configurations before making changes to enable easy rollbacks.
- **Multiple Configurations**: Use different plugin managers, plugin sets, and histories in parallel.

## Getting Started

### Installation

```bash
sudo bash -c 'curl -L https://raw.githubusercontent.com/zinovyev/viver/refs/heads/master/viver -o /usr/bin/viver ; chmod +x /usr/bin/viver'
```

### Creating a New Configuration

1. Run the `viver` command.
2. Select **N** (`New`) from the menu:
   ```
   [E]xecute      Execute the editor with a selected configuration
   [N]ew         Create a new configuration
   [R]emove      Remove an existing configuration
   [L]ist        List available configurations
   [T]est        Preview execution command for a configuration
   [Q]uit        Quit
   ```
3. Choose between a Neovim (`N`) or Vim (`V`) configuration:
   ```
   [V]im         /usr/bin/vim
   [N]eovim      /usr/bin/nvim
   [Q]uit        Go back

   Please choose an editor: N 
   ```
4. Provide a meaningful name for your configuration:
   ```
   Please set the config name: neotest
   ```
5. Your new configuration will be created under `~/.config/viver/setups/neotest`.
6. You can now **list** (`L`), **remove** (`R`), or **execute** (`E`) configurations from the main menu.

### Making a Configuration Executable

To make configurations executable, add the following to your `.bashrc` or `.zshrc`:

```bash
PATH="$HOME/.config/viver/bin:$PATH"
```

Then, reload your shell:

```bash
source ~/.zshrc  # or source ~/.bashrc
```

Now you can run your configuration like a regular command:

```bash
neotest .
```

### Installing `vim-plug`

To install `vim-plug` for an isolated configuration:

1. Download `vim-plug` (replace `<your_setup_name>` with your setup name):
   ```bash
   curl -fLo ~/.config/viver/setups/<your_setup_name>/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   ```
2. Add this to the top of your `init.vim` file:
   ```vim
   call plug#begin("~/.config/viver/<your_setup_name>/code/plugged")

   " List your plugins here
   Plug 'tpope/vim-sensible'

   call plug#end()
   ```
