# Contributing to BPS Chain

Thank you for contributing.
This project welcomes code improvements, tests, documentation updates, and security hardening contributions.

## Workflow

1. Open an issue for bugs, proposals, or large design changes.
2. Create a branch from the default branch.
3. Keep changes focused and atomic.
4. Run validation before opening a pull request.
5. Open a pull request with a clear summary and verification steps.

## Pull Request Expectations

- Use descriptive commit messages.
- Include rationale, not only code changes.
- Add or update tests when behavior changes.
- Update documentation for user-facing or operator-facing changes.
- Keep unrelated refactors out of the same PR.

## Validation

Run at minimum:

```bash
go test ./...
```

Recommended full checks:

```bash
make test
make lint
```

## Security and Secrets

Never commit:

- Mnemonics or seed phrases
- Private keys or validator keys
- API tokens, credentials, or `.env` secrets
- Runtime snapshots or private infrastructure data

If sensitive data is accidentally exposed, rotate and revoke it immediately.

## Bug Report Quality

Please include:

- OS and toolchain versions
- Commit hash or release version
- Chain ID
- Block height (if relevant)
- Full reproduction steps
- Exact logs or errors