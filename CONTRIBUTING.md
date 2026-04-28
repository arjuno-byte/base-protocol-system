# Contributing to BPS Chain

Thanks for taking the time to improve BPS Chain. Clear bug reports, focused
patches, tests, documentation improvements, and security hardening are all very
welcome.

## How to Work With the Project

1. Open an issue for bugs, proposals, or larger design changes.
2. Create a branch from `main`.
3. Keep the change focused on one concern.
4. Add or update tests when behavior changes.
5. Run the relevant validation commands.
6. Open a pull request with a clear summary, rationale, and verification notes.

Small, well-tested pull requests are easier to review and merge.

## Engineering Expectations

- Prefer simple, explicit code over clever abstractions.
- Keep consensus, state, CLI, and module logic in their existing boundaries.
- Avoid unrelated refactors in feature or bug-fix pull requests.
- Update documentation when commands, APIs, parameters, or operator behavior
  changes.
- Include migration notes when a change affects state, genesis, or node
  operation.

## Validation

Run the unit test suite before submitting:

```bash
go test ./...
```

Recommended full validation:

```bash
make test
make lint
```

For protobuf or generated-code changes, also confirm the generated files are
consistent and review the diff carefully.

## Commit and Pull Request Style

Use short, descriptive commit messages. The pull request description should
answer:

- What changed?
- Why is it needed?
- How was it validated?
- What is the operational or security impact?

## Security and Secret Handling

Never commit:

- Mnemonics or seed phrases
- Private keys, validator keys, or node keys
- API tokens, credentials, or `.env` secrets
- Runtime snapshots, node databases, or private infrastructure data

If sensitive data is accidentally exposed, treat it as compromised and rotate it
immediately.

## Bug Report Quality

Helpful bug reports include:

- OS and toolchain versions
- Commit hash or release version
- Chain ID
- Block height, if relevant
- Full reproduction steps
- Exact logs or error output

Thanks for helping keep the project reliable, readable, and safe to operate.
