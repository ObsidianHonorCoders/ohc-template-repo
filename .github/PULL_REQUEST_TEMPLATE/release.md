# Release PR Template

## Release Summary

Describe the release being prepared and the intention of this PR.

- Target version/tag:
- Release type:
  - [ ] Patch
  - [ ] Minor
  - [ ] Major
- Scope of change:

## Code and Build

- [ ] Project configures successfully with CMake
- [ ] Project builds successfully in Release mode
- [ ] Unit/integration tests pass
- [ ] No new compiler warnings introduced
- [ ] Local verification commands recorded below

Verification commands and evidence:

```bash
# Example:
cmake --preset dev
cmake --build --preset dev-build
ctest --preset dev-test --output-on-failure
cmake --preset ci
cmake --build --preset ci-build
ctest --preset ci-test --output-on-failure
```

## Documentation and Governance

- [ ] README reflects current commands and behavior
- [ ] CONTRIBUTING and PR template are up to date
- [ ] SECURITY policy is present and accurate
- [ ] License file is present and correct
- [ ] Changelog/release notes reflect the release state

## CI and Repository Health

- [ ] Pre-commit checks pass
- [ ] CI workflow runs green on required platforms
- [ ] Static analysis passes
- [ ] Formatting checks pass
- [ ] Security scan is clean or any findings are explicitly acknowledged
- [ ] CODEOWNERS reflects active maintainers
- [ ] Issue templates are configured and usable
- [ ] .gitignore covers generated artifacts for active toolchain(s)

## Release Artifacts

- [ ] Version/tag updated in release notes
- [ ] Breaking changes documented (if any)
- [ ] Migration notes included (if needed)
- [ ] Release notes / changelog entry is ready for publication

## Compatibility and Risks

- [ ] No breaking changes
- [ ] Breaking changes included; migration steps are documented below

Migration or compatibility notes:

## Final Release Checklist

- [ ] Release branch/PR is focused on this release only
- [ ] All required CI jobs are green
- [ ] Documentation is accurate and current
- [ ] Release is ready to be tagged and published
