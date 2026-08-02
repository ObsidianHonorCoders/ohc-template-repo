# Release Checklist

Use this checklist before tagging or publishing a release from a template-based repository.

## Code and Build

- [ ] Project configures successfully with CMake
- [ ] Project builds successfully in Release mode
- [ ] Unit/integration tests pass
- [ ] No new compiler warnings introduced

## Documentation and Governance

- [ ] README reflects current commands and behavior
- [ ] CONTRIBUTING and PR template are up to date
- [ ] SECURITY policy is present and accurate
- [ ] License file is present and correct

## CI and Repository Health

- [ ] CI workflow runs green on required platforms
- [ ] CODEOWNERS reflects active maintainers
- [ ] Issue templates are configured and usable
- [ ] .gitignore covers generated artifacts for active toolchain(s)

## Release Artifacts

- [ ] Version/tag updated in release notes
- [ ] Breaking changes documented (if any)
- [ ] Migration notes included (if needed)
