# ai-supported-youtube-learning-platform

Brief: an AI-supported platform for building YouTube-learning workflows (fetch, transcribe, and agent-driven specs).

Quick start

Create a virtual environment and activate it (Linux/macOS):

```bash
python3 -m venv .venv && source .venv/bin/activate
```

Install dependencies:

```bash
pip install -r requirements.txt
```

Run unit tests (fast, no heavy deps required):

```bash
python -m unittest discover -s tests -p "test_*.py" -v
```

Notes for contributors
- Specs for the AI agent live in `SpecsAgents/` and must be included in builds or mounted at runtime.
- The project expects a Flask-style `create_app` factory and keeps external I/O behind adapters (see `.junie/guidelines.md`).
- Heavy ML dependencies (torch, transformers, whisper) can slow installs — prefer CPU wheels or a cached wheelhouse in CI.

CI
- This repository includes a GitHub Actions workflow at `.github/workflows/ci.yml` that runs tests on Python 3.10 and 3.11.

If something is unclear
- See `.junie/guidelines.md` for project-specific developer notes, or ask the maintainer for canonical run/packaging commands.
# ai-supported-youtube-learning-platform
