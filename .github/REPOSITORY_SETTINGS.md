# Repository Settings

This fork updates itself with GitHub Actions and the built-in `GITHUB_TOKEN`.
No external secrets are required.

Required settings:

1. Settings -> Actions -> General -> Workflow permissions:
   - Enable read and write permissions.
2. Actions must be enabled for the repository.

The update workflow commits directly to `main` when a newer official
`openai/codex` release exists. It does not create pull requests, does not
auto-merge pull requests, does not use Cachix, and does not sync from the
original packaging repository.
