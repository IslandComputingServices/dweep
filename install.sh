#!/bin/bash

# dweep Installation Script
# Downloads and installs dweep tool for ICS development

set -e

DWEEP_REPO="https://github.com/IslandComputingServices/dweep.git"
INSTALL_DIR="/usr/local/bin"
TEMP_DIR="/tmp/dweep-install"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
check_macos() {
    if [[ "$(uname)" != "Darwin" ]]; then
        log_error "dweep requires macOS"
        exit 1
    fi
}

# Check for required tools
check_requirements() {
    log_info "Checking requirements..."
    
    local required_tools=("git" "gh" "q")
    local missing_tools=()
    
    for tool in "${required_tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            missing_tools+=("$tool")
        fi
    done
    
    if [[ ${#missing_tools[@]} -gt 0 ]]; then
        log_error "Missing required tools: ${missing_tools[*]}"
        echo
        echo "Please install the missing tools:"
        for tool in "${missing_tools[@]}"; do
            case $tool in
                "git")
                    echo "  • Git: https://git-scm.com/download/mac or 'brew install git'"
                    ;;
                "gh")
                    echo "  • GitHub CLI: brew install gh"
                    ;;
                "q")
                    echo "  • Amazon Q CLI: https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/q-cli.html"
                    ;;
            esac
        done
        exit 1
    fi
    
    # Check Git configuration
    check_git_setup
    
    log_success "All requirements met"
}

# Check Git setup
check_git_setup() {
    log_info "Checking Git configuration..."
    
    # Check if Git is configured
    local git_user_name
    local git_user_email
    
    git_user_name=$(git config --global user.name 2>/dev/null || echo "")
    git_user_email=$(git config --global user.email 2>/dev/null || echo "")
    
    if [[ -z "$git_user_name" || -z "$git_user_email" ]]; then
        log_error "Git is not configured"
        echo
        echo "Please configure Git before installing dweep:"
        echo "  git config --global user.name \"Your Name\""
        echo "  git config --global user.email \"your.email@example.com\""
        echo
        exit 1
    fi
    
    # Check GitHub CLI authentication
    if ! gh auth status &>/dev/null; then
        log_error "GitHub CLI is not authenticated"
        echo
        echo "Please authenticate with GitHub CLI before installing dweep:"
        echo "  gh auth login"
        echo
        echo "This is required to access ICS repositories during workspace setup."
        exit 1
    fi
    
    log_success "Git configuration verified"
}

# Install dweep
install_dweep() {
    log_info "Installing dweep..."
    
    # Clean up any existing temp directory
    rm -rf "$TEMP_DIR"
    
    # Clone the repository
    log_info "Downloading dweep from GitHub..."
    git clone "$DWEEP_REPO" "$TEMP_DIR"
    
    # Copy dweep to install directory
    log_info "Installing to $INSTALL_DIR..."
    sudo cp "$TEMP_DIR/dweep" "$INSTALL_DIR/dweep"
    sudo chmod +x "$INSTALL_DIR/dweep"
    
    # Clean up
    rm -rf "$TEMP_DIR"
    
    log_success "dweep installed successfully!"
}

# Verify installation
verify_installation() {
    log_info "Verifying installation..."
    
    if command -v dweep &> /dev/null; then
        local version=$(dweep -version)
        log_success "Installation verified: $version"
    else
        log_error "Installation failed - dweep not found in PATH"
        exit 1
    fi
}

# Show usage information
show_usage() {
    echo
    echo "=== dweep Installation Complete ==="
    echo
    echo "Usage:"
    echo "  dweep -setup workspace    # Setup a new development workspace"
    echo "  dweep -list              # List existing workspaces"
    echo "  dweep -help              # Show help"
    echo
    echo "Get started:"
    echo "  1. Run: dweep -setup workspace"
    echo "  2. Follow the interactive setup"
    echo "  3. Start developing with ICS standards!"
    echo
}

# Main installation process
main() {
    echo "=== dweep Installation Script ==="
    echo
    
    check_macos
    check_requirements
    install_dweep
    verify_installation
    show_usage
}

main "$@"
