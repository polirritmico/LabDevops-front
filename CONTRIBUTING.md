# Contributions Guides

Here are instructions on how to set the environment and other contributions
guidelines.

## Base instructions

For first-time contributors:

1. Fork the repository.
2. Set your development environment
3. Create your working branch.
4. Run and pass the tests with `pytest`.
5. Sync and create a PR from your branch into the project's `develop` branch.

> [!IMPORTANT]
>
> Each PR must include a minimum and reasonable test coverage relative to the
> scope of the changes/additions.
>
> As a rule of thumb, a coverage of >=70% is usually more than enough.

For core maintainers (contributors with granted permissions after accepted PRs),
push changes directly into the `develop` branch are allowed for a more
trunk-based approach.

## Code standards

The project currently uses these tools:

- **Formatting:** [Black](https://github.com/psf/black).
- **Linter:** [ruff](https://github.com/astral-sh/ruff).
- **Testing:** [pytest](https://github.com/pytest-dev/pytest) with
  [Coverage](https://coverage.readthedocs.io).
- **LSP:** [pylsp](https://github.com/python-lsp/python-lsp-server) with
  [jedi](https://github.com/davidhalter/jedi).

> [!IMPORTANT]
>
> All static analysis checks must be validated before a PR can be merged.

## Pipeline

As stated in the `README`, currently the project has a pipeline process to build
and push the built project Docker image into Docker Hub.

Check the Github Workflow automation script at:
`.github/workflows/build-push.yml`.

## Dev requirements

- Python >=3.13
- venv (or Conda)
- coverage
- black
- pylsp
- jedi
- ruff

## Repository workflow

Check the info on the README. If you have any doubt, feel free to open a new
issue.

### Commits

This project uses
[conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) messages.

For example:

**Good:**

```
fix(api): correct null pointer exception on user fetch
```

```
docs(README): improve setup instructions
```

```
feat(auth): add oauth authentication
```

**Bad:**

```
fix bug in api
```

```
update readme
```

```
feat(auth): Add oauth authentication

```

### Versioning

This project follows [semantic versioning](https://semver.org).

Version tags are created only when merging the `develop` branch into `main`.
Each release tag reflects the impact of the changes included in that merge:

- **MAJOR:** Incompatible or breaking changes.
- **MINOR:** Backwards-compatible changes (functionality, fixes, etc).
- **PATCH:** Backwards-compatible bug fixes.

For example:

- `1.0.0` -> First stable release.
- `1.1.0` -> New backwards-compatible feature added.
- `1.1.1` -> Bug fix that doesn't change the public API.

---

## Setting up the development environment

1. Create the virtual environment.

```bash
python -m venv .venv
```

2. Activate the environment

```bash
source .venv/bin/activate
```

3. Install the libraries in your environment

```bash
python -m pip install -r requirements.txt
python -m pip install -r requirements-dev.txt
```

Now the environment is ready!

> [!TIP]
>
> In the repository there's a Makefile that you could use to run pytest, build
> the Docker image, run pytest through coverage. Check `make help`.

---

## Questions?

If you have any doubts or questions, please open a new thread in the
[Discussions](https://github.com/polirritmico/LabDevops/discussions) section.
This keeps conversations organized and makes answers available to other users
and contributors.

> _Happy codding ☕!_
