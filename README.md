# Neovim Config Installer for Arch Linux

A fully automated build script that installs **everything** needed for a complete personal Neovim setup on Arch Linux. Clones your config from GitHub, installs all dependencies, and bootstraps everything so you can code immediately.

## Features

- ✅ Clones your personal Neovim config from GitHub (`vimpocalypse` repo)
- ✅ Installs all system packages (neovim, git, nodejs, python, go, rust, java, build tools)
- ✅ Installs all language tooling via cargo, npm, pip, go (LSPs, formatters, linters, debuggers)
- ✅ Installs JetBrains Mono Nerd Font
- ✅ Bootstraps lazy.nvim + all plugins headless
- ✅ Installs all 13 Mason LSPs (basedpyright, lua_ls, gopls, rust_analyzer, clangd, vtsls, html, cssls, emmet_ls, jsonls, bashls, yamlls)
- ✅ Installs all 12 Tree-sitter parsers
- ✅ Runs `:checkhealth` to verify everything works

## Usage

```bash
# Clone and run
git clone git@github.com:Dodoprospy3/vim-config-installer-script.git
cd vim-config-installer-script
chmod +x install-nvim-config.sh
./install-nvim-config.sh
```

Or run directly:
```bash
bash <(curl -sL https://raw.githubusercontent.com/Dodoprospy3/vim-config-installer-script/main/install-nvim-config.sh)
```

## What Gets Installed

### System Packages (pacman/paru/yay)
- `neovim`, `git`, `base-devel`, `nodejs`, `npm`, `python`, `python-pip`, `go`, `rust`, `cargo`
- `lazygit`, `fzf`, `ripgrep`, `fd`, `clang`, `cmake`, `make`, `gcc`, `unzip`, `wget`, `curl`
- `jdk-openjdk`, `gradle`, `maven`

### Language Tooling (installed globally)
- **Rust**: rust-analyzer, taplo, stylua, tree-sitter-cli
- **Node.js**: vtsls, typescript-language-server, vue, svelte, astro, tailwindcss, eslint_d, prettier, biome, oxlint, dockerfile, bash, yaml, sql, prisma
- **Python**: basedpyright, ruff, black, isort, mypy, debugpy
- **Go**: gopls, delve, staticcheck
- **Java**: jdtls (Eclipse JDT Language Server)

### Neovim Configuration (cloned from `git@github.com:Dodoprospy3/vimpocalypse.git`)
Your personal from-scratch config with:
- **Plugin manager**: lazy.nvim
- **Completion**: blink.cmp + friendly-snippets
- **AI**: neocodeium (Codeium)
- **LSP**: mason.nvim + mason-lspconfig.nvim + nvim-lspconfig (13 servers)
- **Treesitter**: nvim-treesitter (12 parsers)
- **UI**: lualine, telescope, harpoon, trouble, gitsigns, undotree
- **Themes**: rose-pine + custom transparency settings
- **Keybindings**: Custom leader keys, terminal toggles, Python runner (F5), etc.

### Mason LSPs Installed (13)
| Language | LSP |
|----------|-----|
| Python | basedpyright |
| Lua | lua_ls |
| Go | gopls |
| Rust | rust_analyzer |
| C/C++ | clangd |
| TypeScript/JavaScript | vtsls |
| HTML | html |
| CSS | cssls |
| Emmet | emmet_ls |
| JSON | jsonls |
| Bash | bashls |
| YAML | yamlls |

### Tree-sitter Parsers Installed (12)
lua, vim, vimdoc, bash, python, javascript, typescript, tsx, jsx, html, css, json, markdown

## After Installation

Just run `nvim` and start coding immediately. Everything is pre-configured and ready to use.

## Requirements

- Arch Linux (or Arch-based distro)
- Internet connection
- `sudo` access for package installation
- SSH key configured for GitHub (for cloning via SSH)

## License

MIT