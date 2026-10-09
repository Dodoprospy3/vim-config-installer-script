#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
NVIM_CONFIG_SOURCE="$DOTFILES_DIR/nvim/.config/nvim"
NVIM_CONFIG_TARGET="$HOME/.config/nvim"

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

check_command() {
    command -v "$1" >/dev/null 2>&1
}

install_packages() {
    log_info "Installing base packages..."
    
    local packages=(
        neovim
        git
        base-devel
        nodejs
        npm
        python
        python-pip
        go
        rust
        cargo
        lazygit
        fzf
        ripgrep
        fd
        tree-sitter-cli
        stylua
        lua-language-server
        clang
        cmake
        make
        gcc
        unzip
        wget
        curl
        gzip
        tar
        jdk-openjdk
        gradle
        maven
    )
    
    if check_command paru; then
        paru -S --needed --noconfirm "${packages[@]}"
    elif check_command yay; then
        yay -S --needed --noconfirm "${packages[@]}"
    else
        sudo pacman -S --needed --noconfirm "${packages[@]}"
    fi
    
    log_success "Base packages installed"
}

install_rust_tools() {
    log_info "Installing Rust tools..."
    
    if check_command cargo; then
        cargo install --locked tree-sitter-cli
        cargo install --locked stylua
        cargo install --locked bacon
        cargo install --locked cargo-nextest
        cargo install --locked taplo-cli
        cargo install --locked rust-analyzer
    else
        log_warn "Cargo not found, skipping Rust tools"
    fi
}

install_node_tools() {
    log_info "Installing Node.js tools..."
    
    if check_command npm; then
        npm install -g \
            @vtsls/language-server \
            @tailwindcss/language-server \
            vscode-langservers-extracted \
            dockerfile-language-server-nodejs \
            @angular/language-server \
            bash-language-server \
            diagnostic-languageserver \
            eslint_d \
            prettier \
            @prisma/language-server \
            graphql-language-service-cli \
            yaml-language-server \
            sql-language-server \
            @biomejs/biome \
            @oxlint/language-server \
            @sqltools/formatter \
            typescript-language-server \
            @vue/language-server \
            svelte-language-server \
            @astrojs/language-server \
            @tailwindcss/language-server
    else
        log_warn "npm not found, skipping Node.js tools"
    fi
}

install_python_tools() {
    log_info "Installing Python tools..."
    
    if check_command pip; then
        pip install --user --break-system-packages \
            python-lsp-server \
            ruff \
            black \
            isort \
            mypy \
            pyright \
            debugpy \
            pynvim \
            jedi-language-server
    elif check_command pip3; then
        pip3 install --user --break-system-packages \
            python-lsp-server \
            ruff \
            black \
            isort \
            mypy \
            pyright \
            debugpy \
            pynvim \
            jedi-language-server
    else
        log_warn "pip not found, skipping Python tools"
    fi
}

install_go_tools() {
    log_info "Installing Go tools..."
    
    if check_command go; then
        go install golang.org/x/tools/gopls@latest
        go install github.com/go-delve/delve/cmd/dlv@latest
        go install honnef.co/go/tools/cmd/staticcheck@latest
        go install github.com/nametake/golangci-lint-langserver@latest
        go install github.com/cweill/gotests/gotests@latest
        go install github.com/fatih/gomodifytags@latest
        go install github.com/josharian/impl@latest
        go install github.com/haya14busa/goplay/cmd/goplay@latest
    else
        log_warn "Go not found, skipping Go tools"
    fi
}

install_java_tools() {
    log_info "Installing Java tools..."
    
    if check_command java; then
        mkdir -p "$HOME/.local/share/nvim/mason/packages/jdtls"
        cd /tmp
        wget -q "https://download.eclipse.org/jdtls/snapshots/jdtls-latest.tar.gz" -O jdtls.tar.gz
        tar -xzf jdtls.tar.gz -C "$HOME/.local/share/nvim/mason/packages/jdtls"
        rm -f jdtls.tar.gz
        log_success "jdtls installed"
    else
        log_warn "Java not found, skipping Java tools"
    fi
}

setup_nvim_config() {
    log_info "Setting up Neovim configuration..."
    
    if [[ -d "$NVIM_CONFIG_TARGET" ]] || [[ -L "$NVIM_CONFIG_TARGET" ]]; then
        local backup_dir="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
        mv "$NVIM_CONFIG_TARGET" "$backup_dir"
        log_info "Backed up existing config to $backup_dir"
    fi
    
    mkdir -p "$(dirname "$NVIM_CONFIG_TARGET")"
    cp -r "$NVIM_CONFIG_SOURCE" "$NVIM_CONFIG_TARGET"
    
    log_success "Neovim configuration linked"
}

install_nerd_font() {
    log_info "Installing Nerd Font..."
    
    local font_dir="$HOME/.local/share/fonts"
    mkdir -p "$font_dir"
    
    if [[ ! -f "$font_dir/JetBrainsMonoNerdFont-Regular.ttf" ]]; then
        cd /tmp
        wget -q "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
        unzip -o JetBrainsMono.zip -d "$font_dir"
        fc-cache -fv "$font_dir" >/dev/null 2>&1
        rm -f JetBrainsMono.zip
        log_success "JetBrains Mono Nerd Font installed"
    else
        log_info "Nerd Font already installed"
    fi
}

bootstrap_nvim() {
    log_info "Bootstrapping Neovim (installing lazy.nvim and plugins)..."
    
    nvim --headless "+Lazy! sync" +qa 2>&1 | tail -20
    
    log_success "Neovim bootstrapped"
}

install_mason_tools() {
    log_info "Installing Mason tools (LSPs, formatters, debuggers)..."
    
    nvim --headless "+MasonToolsInstall" +qa 2>&1 | tail -30
    
    log_success "Mason tools installed"
}

install_treesitter_parsers() {
    log_info "Installing Tree-sitter parsers..."
    
    nvim --headless "+TSInstallSync lua vim vimdoc bash python javascript typescript rust go json yaml toml markdown markdown_inline html css scss dockerfile sql regex c cpp java kotlin zig" +qa 2>&1 | tail -20
    
    log_success "Tree-sitter parsers installed"
}

verify_installation() {
    log_info "Verifying installation..."
    
    nvim --headless "+checkhealth" +qa 2>&1 | grep -E "(OK|ERROR|WARNING)" | head -30
    
    log_success "Verification complete"
}

main() {
    log_info "Starting FULL Neovim configuration setup for Arch Linux"
    log_info "This will install everything and make Neovim ready to use immediately"
    
    install_packages
    install_rust_tools
    install_node_tools
    install_python_tools
    install_go_tools
    install_java_tools
    install_nerd_font
    setup_nvim_config
    bootstrap_nvim
    install_mason_tools
    install_treesitter_parsers
    verify_installation
    
    log_success "=== SETUP COMPLETE ==="
    log_success "Neovim is now fully configured and ready to use!"
    log_info "Just run 'nvim' and start coding."
}

main "$@"