<#
.SYNOPSIS
    Renames the OHC template repository to a new project name.

.DESCRIPTION
    This script automates the process of converting the template repository
    into a new project by replacing all placeholder names with the provided
    project name.

.PARAMETER ProjectName
    The new project name (PascalCase, e.g., "MyAwesomeProject").

.PARAMETER ProjectNameSnake
    The project name in snake_case (e.g., "my_awesome_project").
    If not provided, will be derived from ProjectName.

.PARAMETER Namespace
    The C++ namespace (snake_case, e.g., "my_awesome_project").
    If not provided, will be derived from ProjectName.

.PARAMETER Description
    Short project description for README and CMake.

.PARAMETER Author
    Author name for copyright and license.

.PARAMETER Email
    Author email for SECURITY.md and CODEOWNERS.

.PARAMETER GitHubOwner
    GitHub username/organization for URLs.

.EXAMPLE
    .\scripts\rename-template.ps1 -ProjectName "MyAwesomeProject" -Author "John Doe" -Email "john@example.com" -GitHubOwner "johndoe"

.EXAMPLE
    .\scripts\rename-template.ps1 -ProjectName "DataProcessor" -ProjectNameSnake "data_processor" -Namespace "data_processor" -Description "High-performance data processing library" -Author "Jane Smith" -Email "jane@company.com" -GitHubOwner "janesmith"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectName,

    [string]$ProjectNameSnake = "",

    [string]$Namespace = "",

    [string]$Description = "A C++ project based on OHC template",

    [string]$Author = "Your Name",

    [string]$Email = "your.email@example.com",

    [string]$GitHubOwner = "your-github-username"
)

# Derive snake_case if not provided
if (-not $ProjectNameSnake) {
    $ProjectNameSnake = $ProjectName -replace '([a-z])([A-Z])', '$1_$2' -replace '([A-Z]+)([A-Z][a-z])', '$1_$2' -replace ' ', '_' | ForEach-Object { $_.ToLower() }
}

# Derive namespace if not provided
if (-not $Namespace) {
    $Namespace = $ProjectNameSnake
}

$ProjectNameKebab = $ProjectNameSnake -replace '_', '-'
$ProjectNameUpper = $ProjectNameSnake.ToUpper()
$Year = Get-Date -Format "yyyy"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  OHC Template Renaming Script" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Project Name (PascalCase): $ProjectName" -ForegroundColor Green
Write-Host "Project Name (snake_case): $ProjectNameSnake" -ForegroundColor Green
Write-Host "Project Name (kebab-case): $ProjectNameKebab" -ForegroundColor Green
Write-Host "Namespace: $Namespace" -ForegroundColor Green
Write-Host "Description: $Description" -ForegroundColor Green
Write-Host "Author: $Author" -ForegroundColor Green
Write-Host "Email: $Email" -ForegroundColor Green
Write-Host "GitHub Owner: $GitHubOwner" -ForegroundColor Green
Write-Host "Year: $Year" -ForegroundColor Green
Write-Host ""

# Confirm before proceeding
$confirm = Read-Host "Proceed with renaming? (y/N)"
if ($confirm.ToLower() -ne 'y') {
    Write-Host "Aborted." -ForegroundColor Yellow
    exit 0
}

# Files to process with replacements
$replacements = @{
    "ohc_template_repo" = $ProjectNameSnake
    "ohc-template-repo" = $ProjectNameKebab
    "OHC_TEMPLATE_REPO" = $ProjectNameUpper
    "template_repo" = $Namespace
    "OHC Template Repo" = $ProjectName
    "OHC template repo" = $ProjectName
    "ohc_template_app" = "${ProjectNameSnake}_app"
    "template_module" = "${ProjectNameSnake}_module"
    "Calileus" = $Author
    "calileus" = $GitHubOwner.ToLower()
    "CalileusLab" = $GitHubOwner
    "your.email@example.com" = $Email
    "your-github-username" = $GitHubOwner
    "2026" = $Year
}

# Files to process
$filesToProcess = @(
    "CMakeLists.txt",
    "CMakePresets.json",
    "cmakehelpers/quick_build.cmake",
    "README.md",
    "docs/DoxyPage/Doxyfile",
    "SECURITY.md",
    "CONTRIBUTING.md",
    "CODE_OF_CONDUCT.md",
    "CHANGELOG.md",
    "cmake/ohc_template_repo-config.cmake.in",
    "include/template_module.hpp",
    "src/template_module.cpp",
    "tests/test_template_module.cpp",
    "tests/CMakeLists.txt",
    "main.cpp",
    ".github/CODEOWNERS",
    ".github/pull_request_template.md",
    ".github/ISSUE_TEMPLATE/bug_report.md",
    ".github/ISSUE_TEMPLATE/feature_request.md",
    ".github/ISSUE_TEMPLATE/config.yml",
    ".github/workflows/ci.yml",
    ".github/dependabot.yml",
    "cmakehelpers/detect_generator.cmake",
    "docs/release_checklist.md",
    "NAMING_CONVENTIONS.md"
)

Write-Host "`nProcessing files..." -ForegroundColor Cyan

foreach ($file in $filesToProcess) {
    $fullPath = Join-Path $PSScriptRoot ".." $file
    if (Test-Path $fullPath) {
        $content = Get-Content $fullPath -Raw
        $originalContent = $content

        foreach ($pair in $replacements.GetEnumerator()) {
            $content = $content -replace [regex]::Escape($pair.Key), $pair.Value
        }

        if ($content -ne $originalContent) {
            Set-Content -Path $fullPath -Value $content -Encoding UTF8
            Write-Host "  ✓ Updated: $file" -ForegroundColor Green
        } else {
            Write-Host "  - No changes: $file" -ForegroundColor Gray
        }
    } else {
        Write-Host "  ⚠ Not found: $file" -ForegroundColor Yellow
    }
}

# Rename files/directories
Write-Host "`nRenaming files and directories..." -ForegroundColor Cyan

# Rename template_module.hpp/cpp
$oldHeader = Join-Path $PSScriptRoot ".." "include" "template_module.hpp"
$newHeader = Join-Path $PSScriptRoot ".." "include" "${ProjectNameSnake}_module.hpp"
if (Test-Path $oldHeader) {
    Rename-Item $oldHeader $newHeader
    Write-Host "  ✓ Renamed: include/template_module.hpp -> include/${ProjectNameSnake}_module.hpp" -ForegroundColor Green
}

$oldSource = Join-Path $PSScriptRoot ".." "src" "template_module.cpp"
$newSource = Join-Path $PSScriptRoot ".." "src" "${ProjectNameSnake}_module.cpp"
if (Test-Path $oldSource) {
    Rename-Item $oldSource $newSource
    Write-Host "  ✓ Renamed: src/template_module.cpp -> src/${ProjectNameSnake}_module.cpp" -ForegroundColor Green
}

# Rename test file
$oldTest = Join-Path $PSScriptRoot ".." "tests" "test_template_module.cpp"
$newTest = Join-Path $PSScriptRoot ".." "tests" "test_${ProjectNameSnake}_module.cpp"
if (Test-Path $oldTest) {
    Rename-Item $oldTest $newTest
    Write-Host "  ✓ Renamed: tests/test_template_module.cpp -> tests/test_${ProjectNameSnake}_module.cpp" -ForegroundColor Green
}

# Rename cmake config template
$oldCmakeConfig = Join-Path $PSScriptRoot ".." "cmake" "ohc_template_repo-config.cmake.in"
$newCmakeConfig = Join-Path $PSScriptRoot ".." "cmake" "${ProjectNameSnake}-config.cmake.in"
if (Test-Path $oldCmakeConfig) {
    Rename-Item $oldCmakeConfig $newCmakeConfig
    Write-Host "  ✓ Renamed: cmake/ohc_template_repo-config.cmake.in -> cmake/${ProjectNameSnake}-config.cmake.in" -ForegroundColor Green
}

# Update CMakeLists.txt to reference new config file name
$cmakeLists = Join-Path $PSScriptRoot ".." "CMakeLists.txt"
if (Test-Path $cmakeLists) {
    $content = Get-Content $cmakeLists -Raw
    $content = $content -replace 'ohc_template_repo-config\.cmake\.in', "${ProjectNameSnake}-config.cmake.in"
    Set-Content -Path $cmakeLists -Value $content -Encoding UTF8
    Write-Host "  ✓ Updated CMakeLists.txt config reference" -ForegroundColor Green
}

Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host "  Renaming Complete!" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Review all changes: git diff"
Write-Host "2. Run: cmake --preset dev && cmake --build --preset dev-build"
Write-Host "3. Run tests: ctest --preset dev-test --output-on-failure"
Write-Host "4. Commit changes: git add -A && git commit -m 'chore: rename template to $ProjectName'"
Write-Host "5. Update remote origin: git remote set-url origin https://github.com/$GitHubOwner/$ProjectNameKebab.git"
Write-Host ""
Write-Host "Happy coding! 🚀" -ForegroundColor Green
