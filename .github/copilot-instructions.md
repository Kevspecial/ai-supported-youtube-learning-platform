# Copilot / AI Agent Instructions (project-specific)

Purpose
- Very short, actionable notes to get an AI coding agent productive in this repo.

High-level orientation
- Major pieces: `SpecsAgents/` (agent specs and policies), a Python backend (Flask-style app factory), and ML/audio adapters for YouTube fetching, transcription, and LLM calls.
- Design intent: keep I/O and external integrations behind thin, dependency-injectable adapters so logic is testable without heavy models.

Essential facts (from `.junie/guidelines.md`)
- Python supported: 3.10–3.11 recommended.
- Dependency manifest: `requirements.txt` (do not rename; CI and tooling rely on it).
- Heavy libs: expect `torch`, `transformers`, `openai-whisper`, `accelerate`, `yt-dlp`, `gunicorn` — installs can be slow; prefer CPU wheels or cached wheelhouse in CI.
- Specs under `SpecsAgents/` are runtime config for the agent; ensure they are included in builds or mounted at runtime.

Concrete commands
- Create a venv and activate (Linux/macOS):
  python3 -m venv .venv && source .venv/bin/activate
- Install deps:
  pip install -r requirements.txt
- Run unit tests (no heavy deps required):
  python -m unittest discover -s tests -p "test_*.py" -v
- Run pytest (if present):
  pytest -q

Env & secrets
- Use a `.env` file at project root for API keys (project uses `python-dotenv`). Typical vars: `OPENAI_API_KEY` and any downstream service keys.

Project conventions and patterns
- App factory: expect a `create_app` pattern for the Flask backend (enables test client use). Keep route handlers thin and move business logic to services/adapters.
- Adapters: external I/O (YouTube download, transcription, LLM) should live in clear namespaces (e.g., `adapters.youtube`, `adapters.transcription`, `services.llm`).
- Tests: avoid calling heavy models or network I/O in unit tests—mock adapters and use tiny fixture artifacts for audio/ML components.

Edit guidance for AI agents
- When changing code that touches external services, add or use dependency injection so tests can mock those boundaries.
- If you modify `SpecsAgents/`, update packaging/deploy steps and mention the change in the PR description so Specs are available at runtime.
- Keep changes small and focused; do not add heavy installs to CI without maintainers' approval.

Where to look first
- `SpecsAgents/` — agent specs and policies.
- `.junie/guidelines.md` — project-specific developer notes and gotchas.
- `README.md` — repo overview and run instructions.
- `requirements.txt` — dependency list; watch for heavy ML libs.

If something is unclear
- Ask the maintainer for: canonical dev/run command for the backend, the `create_app` import path if present, and whether `SpecsAgents/` are mounted or baked into CI images.

After edits
- Run the unit tests:
  python -m unittest discover -s tests -p "test_*.py" -v
and report any failures and large installs required.

-- End
