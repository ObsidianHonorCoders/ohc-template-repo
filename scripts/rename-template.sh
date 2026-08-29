#!/usr/bin/env bash
# Renames the OHC template repository to a new project name
# Usage: ./scripts/rename-template.sh <ProjectName> [options]

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Default values
PROJECT_NAME=""
PROJECT_NAME_SNAKE=""
NAMESPACE=""
DESCRIPTION="A C++ project based on OHC template"
AUTHOR="Your Name"
EMAIL="your.email@example.com"
GITHUB_OWNER="your-github-username"

# Help function
show_help() {
    cat << EOF
Usage: $0 <ProjectName> [OPTIONS]

Renames the OHC template repository to a new project name.

ARGUMENTS:
    ProjectName       New project name in PascalCase (e.g., "MyAwesomeProject")

OPTIONS:
    -s, --snake-case      Project name in snake_case (default: derived from ProjectName)
    -n, --namespace       C++ namespace (default: derived from ProjectName)
    -d, --description     Project description (default: "A C++ project based on OHC template")
    -a, --author          Author name (default: "Your Name")
    -e, --email           Author email (default: "your.email@example.com")
    -g, --github-owner    GitHub username/organization (default: "your-github-username")
    -h, --help            Show this help message

EXAMPLES:
    $0 MyAwesomeProject -a "John Doe" -e "john@example.com" -g "johndoe"
    $0 DataProcessor -s data_processor -n data_processor -d "High-performance data processing" -a "Jane Smith" -g "janesmith"

EOF
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -s|--snake-case)
            PROJECT_NAME_SNAKE="$2"
            shift 2
            ;;
        -n|--namespace)
            NAMESPACE="$2"
            shift 2
            ;;
        -d|--description)
            DESCRIPTION="$2"
            shift 2
            ;;
        -a|--author)
            AUTHOR="$2"
            shift 2
            ;;
        -e|--email)
            EMAIL="$2"
            shift 2
            ;;
        -g|--github-owner)
            GITHUB_OWNER="$2"
            shift 2
            ;;
        -*)
            echo -e "${RED}Unknown option: $1${NC}"
            show_help
            exit 1
            ;;
        *)
            if [[ -z "$PROJECT_NAME" ]]; then
                PROJECT_NAME="$1"
            else
                echo -e "${RED}Too many arguments${NC}"
                show_help
                exit 1
            fi
            shift
            ;;
    esac
done

# Validate required argument
if [[ -z "$PROJECT_NAME" ]]; then
    echo -e "${RED}Error: ProjectName is required${NC}"
    show_help
    exit 1
fi

# Derive snake_case if not provided
if [[ -z "$PROJECT_NAME_SNAKE" ]]; then
    # Convert PascalCase to snake_case
    PROJECT_NAME_SNAKE=$(echo "$PROJECT_NAME" | sed -E 's/([a-z])([A-Z])/\1_\2/g' | sed -E 's/([A-Z]+)([A-Z][a-z])/\1_\2/g' | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
fi

# Derive namespace if not provided
if [[ -z "$NAMESPACE" ]]; then
    NAMESPACE="$PROJECT_NAME_SNAKE"
fi

PROJECT_NAME_KEBAB=$(echo "$PROJECT_NAME_SNAKE" | tr '_' '-')
PROJECT_NAME_UPPER=$(echo "$PROJECT_NAME_SNAKE" | tr '[:lower:]' '[:upper:]')
YEAR=$(date +%Y)

echo -e "${CYAN}==========================================${NC}"
echo -e "${CYAN}  OHC Template Renaming Script${NC}"
echo -e "${CYAN}==========================================${NC}"
echo ""
echo -e "Project Name (PascalCase): ${GREEN}$PROJECT_NAME${NC}"
echo -e "Project Name (snake_case): ${GREEN}$PROJECT_NAME_SNAKE${NC}"
echo -e "Project Name (kebab-case): ${GREEN}$PROJECT_NAME_KEBAB${NC}"
echo -e "Namespace: ${GREEN}$NAMESPACE${NC}"
echo -e "Description: ${GREEN}$DESCRIPTION${NC}"
echo -e "Author: ${GREEN}$AUTHOR${NC}"
echo -e "Email: ${GREEN}$EMAIL${NC}"
echo -e "GitHub Owner: ${GREEN}$GITHUB_OWNER${NC}"
echo -e "Year: ${GREEN}$YEAR${NC}"
echo ""

# Confirm before proceeding
read -p "Proceed with renaming? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Aborted.${NC}"
    exit 0
fi

# Files to process with replacements
declare -A REPLACEMENTS=(
    ["ohc_template_repo"]="$PROJECT_NAME_SNAKE"
    ["ohc-template-repo"]="$PROJECT_NAME_KEBAB"
    ["OHC_TEMPLATE_REPO"]="$PROJECT_NAME_UPPER"
    ["template_repo"]="$NAMESPACE"
    ["OHC Template Repo"]="$PROJECT_NAME"
    ["OHC template repo"]="$PROJECT_NAME"
    ["ohc_template_app"]="${PROJECT_NAME_SNAKE}_app"
    ["template_module"]="${PROJECT_NAME_SNAKE}_module"
    ["Calileus"]="$AUTHOR"
    ["calileus"]="${GITHUB_OWNER,,}"
    ["CalileusLab"]="$GITHUB_OWNER"
    ["your.email@example.com"]="$EMAIL"
    ["your-github-username"]="$GITHUB_OWNER"
    ["2026"]="$YEAR"
)

# Files to process
FILES_TO_PROCESS=(
    "CMakeLists.txt"
    "CMakePresets.json"
    "build_and_run_project.cmake"
    "README.md"
    "Doxyfile"
    "SECURITY.md"
    "CONTRIBUTING.md"
    "CODE_OF_CONDUCT.md"
    "CHANGELOG.md"
    "cmake/ohc_template_repo-config.cmake.in"
    "include/template_module.hpp"
    "src/template_module.cpp"
    "tests/test_template_module.cpp"
    "tests/CMakeLists.txt"
    "main.cpp"
    ".github/CODEOWNERS"
    ".github/pull_request_template.md"
    ".github/ISSUE_TEMPLATE/bug_report.md"
    ".github/ISSUE_TEMPLATE/feature_request.md"
    ".github/ISSUE_TEMPLATE/config.yml"
    ".github/workflows/ci.yml"
    ".github/dependabot.yml"
    "cmakehelpers/detect_generator.cmake"
    "docs/release_checklist.md"
    "NAMING_CONVENTIONS.md"
)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

echo -e "\n${CYAN}Processing files...${NC}"

for file in "${FILES_TO_PROCESS[@]}"; do
    full_path="$REPO_ROOT/$file"
    if [[ -f "$full_path" ]]; then
        content=$(cat "$full_path")
        original_content="$content"

        for key in "${!REPLACEMENTS[@]}"; do
            value="${REPLACEMENTS[$key]}"
            # Escape special regex characters in key
            escaped_key=$(echo "$key" | sed 's/[[\.*^$()+?{|\\]/\\&/g')
            content=$(echo "$content" | sed "s/$escaped_key/$value/g")
        done

        if [[ "$content" != "$original_content" ]]; then
            echo "$content" > "$full_path"
            echo -e "  ${GREEN}✓ Updated: $file${NC}"
        else
            echo -e "  ${NC}- No changes: $file${NC}"
        fi
    else
        echo -e "  ${YELLOW}⚠ Not found: $file${NC}"
    fi
done

# Rename files/directories
echo -e "\n${CYAN}Renaming files and directories...${NC}"

# Rename template_module.hpp/cpp
old_header="$REPO_ROOT/include/template_module.hpp"
new_header="$REPO_ROOT/include/${PROJECT_NAME_SNAKE}_module.hpp"
if [[ -f "$old_header" ]]; then
    mv "$old_header" "$new_header"
    echo -e "  ${GREEN}✓ Renamed: include/template_module.hpp -> include/${PROJECT_NAME_SNAKE}_module.hpp${NC}"
fi

old_source="$REPO_ROOT/src/template_module.cpp"
new_source="$REPO_ROOT/src/${PROJECT_NAME_SNAKE}_module.cpp"
if [[ -f "$old_source" ]]; then
    mv "$old_source" "$new_source"
    echo -e "  ${GREEN}✓ Renamed: src/template_module.cpp -> src/${PROJECT_NAME_SNAKE}_module.cpp${NC}"
fi

# Rename test file
old_test="$REPO_ROOT/tests/test_template_module.cpp"
new_test="$REPO_ROOT/tests/test_${PROJECT_NAME_SNAKE}_module.cpp"
if [[ -f "$old_test" ]]; then
    mv "$old_test" "$new_test"
    echo -e "  ${GREEN}✓ Renamed: tests/test_template_module.cpp -> tests/test_${PROJECT_NAME_SNAKE}_module.cpp${NC}"
fi

# Rename cmake config template
old_cmake_config="$REPO_ROOT/cmake/ohc_template_repo-config.cmake.in"
new_cmake_config="$REPO_ROOT/cmake/${PROJECT_NAME_SNAKE}-config.cmake.in"
if [[ -f "$old_cmake_config" ]]; then
    mv "$old_cmake_config" "$new_cmake_config"
    echo -e "  ${GREEN}✓ Renamed: cmake/ohc_template_repo-config.cmake.in -> cmake/${PROJECT_NAME_SNAKE}-config.cmake.in${NC}"
fi

# Update CMakeLists.txt to reference new config file name
cmake_lists="$REPO_ROOT/CMakeLists.txt"
if [[ -f "$cmake_lists" ]]; then
    sed -i "s/ohc_template_repo-config\\.cmake\\.in/${PROJECT_NAME_SNAKE}-config.cmake.in/g" "$cmake_lists"
    echo -e "  ${GREEN}✓ Updated CMakeLists.txt config reference${NC}"
fi

echo -e "\n${CYAN}==========================================${NC}"
echo -e "${CYAN}  Renaming Complete!${NC}"
echo -e "${CYAN}==========================================${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Review all changes: git diff"
echo "2. Run: cmake --preset dev && cmake --build --preset dev-build"
echo "3. Run tests: ctest --preset dev-test --output-on-failure"
echo "4. Commit changes: git add -A && git commit -m 'chore: rename template to $PROJECT_NAME'"
echo "5. Update remote origin: git remote set-url origin https://github.com/$GITHUB_OWNER/$PROJECT_NAME_KEBAB.git"
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}"
