# Neovim Config Installer for Arch Linux

A fully automated build script that installs **everything** needed for a complete AstroNvim v5 setup on Arch Linux.

## Features

- ✅ Installs all system packages (neovim, git, nodejs, python, go, rust, java, build tools)
- ✅ Installs all language tooling via cargo, npm, pip, go (LSPs, formatters, linters, debuggers)
- ✅ Installs JetBrains Mono Nerd Font
- ✅ Sets up your AstroNvim configuration
- ✅ Bootstraps lazy.nvim + all plugins headless
- ✅ Runs `:MasonToolsInstall` for all LSPs/formatters/debuggers
- ✅ Installs Tree-sitter parsers for all configured languages
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
- `lazygit`, `fzf`, `ripgrep`, `fd`, `tree-sitter-cli`, `stylua`, `lua-language-server`
- `clang`, `cmake`, `make`, `gcc`, `unzip`, `wget`, `curl`, `jdk-openjdk`, `gradle`, `maven`

### Language Tooling
- **Rust**: rust-analyzer, taplo, bacon, cargo-nextest
- **Node.js**: TypeScript, Vue, Svelte, Astro, Tailwind, ESLint, Prettier, Biome, Oxlint, Docker, Bash, YAML, SQL, GraphQL, Prisma, Angular
- **Python**: pyright, ruff, black, isort, mypy, debugpy, python-lsp-server, jedi-language-server
- **Go**: gopls, delve, staticcheck, golangci-lint-langserver, gotests, gomodifytags, impl
- **Java**: jdtls (Eclipse JDT Language Server)

### Neovim Configuration
Your AstroNvim v5 config with:
- AstroNvim core + community packs
- Custom plugins (kanagawa theme, copilot, markdown-preview, git-conflict, zen-mode, fugitive, silicon, cellular-automaton, minimap, typr, crates.nvim, codex, krust, houdini, tv.nvim, and more)
- LSP configuration with format-on-save
- Custom keybindings for all tools

## After Installation

Just run `nvim` and start coding immediately. Everything is pre-configured and ready to use.

## Requirements

- Arch Linux (or Arch-based distro)
- Internet connection
- `sudo` access for package installation
- SSH key configured for GitHub (for cloning via SSH)

## License

MIT