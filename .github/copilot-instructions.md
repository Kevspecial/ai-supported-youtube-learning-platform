# Copilot / AI Agent Instructions (project-specific)

Purpose
- Short, actionable guidance so an AI coding agent can be productive immediately in this repository.

Quick orientation
- Big pieces: `SpecsAgents/` (agent-level spec Markdown), Python backend (Flask patterns noted in `.junie/guidelines.md`), and ML/audio adapters (YouTube fetch, transcription, LLM calls).
- Key files: `README.md`, `SpecsAgents/`, `.junie/guidelines.md`, and `requirements.txt`.

What to know about architecture
- Agent specs live in `SpecsAgents/` and are treated as runtime/config data—include them in builds and container images or mount them at runtime.
- The codebase favors an app-factory pattern for web components (create a Flask `create_app`) and thin adapters around external I/O (YouTube, Whisper/Transformers, LLM APIs).
- Keep changes localized: adapters and blueprints encapsulate external integrations. Look for functions or modules named around `transcribe`, `fetch_youtube`, or `llm`.

Build / dev / test commands (concrete)
- Create venv and activate (Linux/macOS):
  python3 -m venv .venv && source .venv/bin/activate
- Install deps:
  pip install -r requirements.txt
- Run lightweight tests (unittest):
  python -m unittest discover -s tests -p "test_*.py" -v
- Run pytest (if present):
  pytest -q

Environment and secrets
- Use a `.env` in the project root for local API keys; the project uses `python-dotenv` per `.junie/guidelines.md`.
- Never hard-code API keys or model credentials; prefer env vars with sane defaults.

Project-specific conventions (from `.junie/guidelines.md`)
- Dependency caveat: heavy ML packages (torch, transformers, whisper) make installs slow—prefer CPU wheels in CI or a cached wheelhouse.
- Specs in `SpecsAgents/` must be text-first and small when possible; the agent expects to read them relative to project root.
- Tests should avoid invoking heavyweight models or network I/O; prefer mocking and tiny fixtures for ML components.

Edit guidance for AI agents
- When editing code paths that call external services, add dependency-injectable hooks so tests can mock them (follow existing adapter patterns).
- For any change touching `SpecsAgents/`, update packaging/deploy scripts and mention the specs in the PR description.
- Keep changes small and well-scoped; prefer adding new modules under clear namespaces (e.g., `adapters.youtube`, `adapters.transcription`, `services.llm`).

Where to look first
- `SpecsAgents/` — agent policies and spec text (start here for behavior changes).
- `.junie/guidelines.md` — project-specific developer notes and gotchas.
- `README.md` — repository-level overview and any run instructions.
- `requirements.txt` — dependency constraints; watch for heavy ML libs.

If anything is unclear
- Ask the maintainer for: (A) the canonical dev/run command for the backend, (B) whether a `create_app` factory exists and its import path, and (C) whether SpecsAssets are mounted or baked into images in CI.

After changes
- Run `python -m unittest discover -s tests -p "test_*.py" -v` (or `pytest -q`) and report failures and any heavy installs required.

— End of file
