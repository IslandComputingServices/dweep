#!/bin/bash

# Test script for dweep tool
# Validates all functionality without creating actual workspaces

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DWEEP_SCRIPT="$SCRIPT_DIR/dweep"
TEST_WORKSPACES_DIR="/tmp/dweep-test-workspaces"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

log_test() {
    echo -e "${BLUE}[TEST]${NC} $1"
    ((TESTS_RUN++))
}

log_pass() {
    echo -e "${GREEN}[PASS]${NC} $1"
    ((TESTS_PASSED++))
}

log_fail() {
    echo -e "${RED}[FAIL]${NC} $1"
    ((TESTS_FAILED++))
}

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

# Setup test environment
setup_test_env() {
    log_info "Setting up test environment..."
    
    # Create temporary workspaces directory
    mkdir -p "$TEST_WORKSPACES_DIR"
    
    # Override WORKSPACES_DIR for testing
    export WORKSPACES_DIR="$TEST_WORKSPACES_DIR"
    
    log_info "Test environment ready: $TEST_WORKSPACES_DIR"
}

# Cleanup test environment
cleanup_test_env() {
    log_info "Cleaning up test environment..."
    rm -rf "$TEST_WORKSPACES_DIR"
    log_info "Test environment cleaned up"
}

# Test dweep script exists and is executable
test_script_exists() {
    log_test "Testing dweep script exists and is executable"
    
    if [[ -f "$DWEEP_SCRIPT" && -x "$DWEEP_SCRIPT" ]]; then
        log_pass "dweep script exists and is executable"
    else
        log_fail "dweep script not found or not executable: $DWEEP_SCRIPT"
    fi
}

# Test help command
test_help_command() {
    log_test "Testing help command"
    
    if "$DWEEP_SCRIPT" -help > /dev/null 2>&1; then
        log_pass "Help command works"
    else
        log_fail "Help command failed"
    fi
}

# Test version command
test_version_command() {
    log_test "Testing version command"
    
    local version_output
    version_output=$("$DWEEP_SCRIPT" -version 2>/dev/null)
    
    if [[ "$version_output" =~ ^dweep\ version\ [0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        log_pass "Version command works: $version_output"
    else
        log_fail "Version command failed or invalid format: $version_output"
    fi
}

# Test list command with empty workspaces
test_list_empty() {
    log_test "Testing list command with empty workspaces"
    
    if "$DWEEP_SCRIPT" -list > /dev/null 2>&1; then
        log_pass "List command works with empty workspaces"
    else
        log_fail "List command failed with empty workspaces"
    fi
}

# Test invalid command
test_invalid_command() {
    log_test "Testing invalid command handling"
    
    if ! "$DWEEP_SCRIPT" -invalid > /dev/null 2>&1; then
        log_pass "Invalid command properly rejected"
    else
        log_fail "Invalid command should have failed"
    fi
}

# Test workspace creation (dry run simulation)
test_workspace_creation_simulation() {
    log_test "Testing workspace creation logic (simulation)"
    
    # Create a mock workspace directory to test list functionality
    local mock_workspace="$TEST_WORKSPACES_DIR/TestService-testuser"
    mkdir -p "$mock_workspace/.dweep"
    echo "service" > "$mock_workspace/.dweep/workspace_type"
    echo "TestService" > "$mock_workspace/.dweep/system_name"
    echo "2025-01-01T00:00:00Z" > "$mock_workspace/.dweep/created_at"
    echo "1.0.0" > "$mock_workspace/.dweep/dweep_version"
    
    # Test list command with mock workspace
    local list_output
    list_output=$("$DWEEP_SCRIPT" -list 2>/dev/null)
    
    if [[ "$list_output" =~ TestService-testuser.*service ]]; then
        log_pass "Workspace listing works correctly"
    else
        log_fail "Workspace listing failed: $list_output"
    fi
}

# Test specification template validation
test_specification_templates() {
    log_test "Testing specification template creation logic"
    
    # This would be tested in a full integration test
    # For now, we just validate the script structure
    if grep -q "create_specification_templates" "$DWEEP_SCRIPT"; then
        log_pass "Specification template creation function exists"
    else
        log_fail "Specification template creation function not found"
    fi
}

# Test AI instructions creation
test_ai_instructions() {
    log_test "Testing AI instructions creation logic"
    
    if grep -q "create_ai_instructions" "$DWEEP_SCRIPT"; then
        log_pass "AI instructions creation function exists"
    else
        log_fail "AI instructions creation function not found"
    fi
}

# Test required functions exist
test_required_functions() {
    log_test "Testing required functions exist in script"
    
    local required_functions=(
        "check_requirements"
        "setup_workspace"
        "create_workspace"
        "setup_new_service"
        "setup_new_worker"
        "setup_new_website"
        "setup_existing_system"
    )
    
    local missing_functions=()
    
    for func in "${required_functions[@]}"; do
        if ! grep -q "$func()" "$DWEEP_SCRIPT"; then
            missing_functions+=("$func")
        fi
    done
    
    if [[ ${#missing_functions[@]} -eq 0 ]]; then
        log_pass "All required functions exist"
    else
        log_fail "Missing functions: ${missing_functions[*]}"
    fi
}

# Test script structure and syntax
test_script_syntax() {
    log_test "Testing script syntax"
    
    if bash -n "$DWEEP_SCRIPT"; then
        log_pass "Script syntax is valid"
    else
        log_fail "Script has syntax errors"
    fi
}

# Test constants and configuration
test_constants() {
    log_test "Testing script constants"
    
    local required_constants=(
        "DWEEP_VERSION"
        "ICS_STANDARDS_REPO"
        "WORKSPACES_DIR"
    )
    
    local missing_constants=()
    
    for const in "${required_constants[@]}"; do
        if ! grep -q "$const=" "$DWEEP_SCRIPT"; then
            missing_constants+=("$const")
        fi
    done
    
    if [[ ${#missing_constants[@]} -eq 0 ]]; then
        log_pass "All required constants defined"
    else
        log_fail "Missing constants: ${missing_constants[*]}"
    fi
}

# Run all tests
run_all_tests() {
    echo "=== dweep Tool Test Suite ==="
    echo
    
    setup_test_env
    
    # Basic functionality tests
    test_script_exists
    test_script_syntax
    test_constants
    test_required_functions
    
    # Command tests
    test_help_command
    test_version_command
    test_list_empty
    test_invalid_command
    
    # Functionality tests
    test_workspace_creation_simulation
    test_specification_templates
    test_ai_instructions
    
    cleanup_test_env
    
    # Test summary
    echo
    echo "=== Test Results ==="
    echo "Tests Run: $TESTS_RUN"
    echo -e "Tests Passed: ${GREEN}$TESTS_PASSED${NC}"
    echo -e "Tests Failed: ${RED}$TESTS_FAILED${NC}"
    
    if [[ $TESTS_FAILED -eq 0 ]]; then
        echo -e "${GREEN}All tests passed!${NC}"
        exit 0
    else
        echo -e "${RED}Some tests failed!${NC}"
        exit 1
    fi
}

# Main execution
main() {
    case "${1:-}" in
        --help|-h)
            echo "dweep Test Suite"
            echo
            echo "Usage: $0 [options]"
            echo
            echo "Options:"
            echo "  --help, -h    Show this help message"
            echo "  (no args)     Run all tests"
            ;;
        *)
            run_all_tests
            ;;
    esac
}

main "$@"
