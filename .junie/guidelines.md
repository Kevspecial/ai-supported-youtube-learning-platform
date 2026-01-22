AI-Supported YouTube Learning Platform — Development Guidelines

This document captures project-specific practices so advanced contributors can get productive quickly and avoid common pitfalls.

Build and configuration
- Python version: 3.10–3.11 recommended. PyTorch in `torch~=2.5` supports these versions best across CPU/CUDA.
- Dependency file: note the non-standard filename `requirementstxt` (intentionally no dot). Tools that assume `requirements.txt` will not find it by default. Use an explicit path when installing.
  - Create a virtual environment (example):
    - macOS/Linux/WSL: `python3 -m venv .venv && source .venv/bin/activate`
    - Windows (PowerShell): `py -3 -m venv .venv; .\.venv\Scripts\Activate.ps1`
  - Install minimal runtime deps (CPU only) when you don’t need Whisper/Transformers locally:
    - `pip install -r requirements.txt --only-binary :all: --no-deps` is NOT recommended as a general approach; prefer standard resolution unless you know what you’re doing.
  - Typical full install (may be heavy): `pip install -r requirements.txt`
    - Heavy packages: `torch`, `transformers`, `openai-whisper`, `accelerate`, `yt-dlp`, `gunicorn`.
    - If you don’t need GPU locally, do not install CUDA wheels. For PyTorch CPU-only: `pip install torch==2.5.*+cpu -f https://download.pytorch.org/whl/torch_stable.html` before the rest, or let `pip` resolve CPU wheels automatically on many platforms.
- Environment variables: the project likely expects API keys for OpenAI and others at runtime.
  - Place a `.env` file in the project root for local runs (supported via `python-dotenv`):
    - `OPENAI_API_KEY=...`
    - Any additional keys for downstream services as you introduce them.

Agent specs (SpecsAgents/)
- The `SpecsAgents/` directory at the project root contains Markdown (`.md`) specification files used by the AI agent.
- When building/packaging/deploying the app, this folder MUST be reviewed and included so the agent can load the required specs at runtime.
- For local runs, the application should be able to read specs from `SpecsAgents/` relative to the project root. In containerized builds, copy this folder into the image or mount it as a volume.
- Keep spec files small and text-based where possible to ease code review. If large/binary assets are unavoidable, consider configuring Git LFS for those assets.

Testing
- Frameworks available:
  - `pytest` is listed in `requirementstxt` but is not required for trivial checks; Python’s built-in `unittest` works without extra installation.
  - Prefer `pytest` for substantive test suites; `unittest` is fine for quick smoke tests or when avoiding heavy environment setup.
- Test layout (recommended):
  - Use a `tests/` package at the project root.
  - Name tests `test_*.py` so both `pytest` and `unittest` discovery find them easily.
- Running tests:
  - With unittest (no extra deps): `python -m unittest discover -s tests -p "test_*.py" -v`
  - With pytest: `pytest -q` or `pytest -q tests/`
  - In CI, avoid importing optional heavy packages unless the test needs them; prefer fast, isolated tests.
- Adding tests:
  - Keep tests independent of network and heavyweight models unless explicitly needed; mock I/O and external APIs.
  - For audio/ML components (Whisper/Transformers), prefer fixture-based tests around precomputed tiny artifacts rather than invoking full models.

Demonstration: creating and running a simple test
- We verified locally that a trivial `unittest` test runs green without extra dependencies. The file was created transiently and removed afterward to keep the repository clean.
- Reproduce locally:
  1. Create `tests/test_sanity.py` with:
     ```python
     import unittest

     class SanityTest(unittest.TestCase):
         def test_truth(self):
             self.assertTrue(True)

     if __name__ == "__main__":
         unittest.main()
     ```
  2. Run: `python -m unittest discover -s tests -p "test_*.py" -v`
  3. You should see one passing test. Delete the temporary file afterward if it’s not part of a permanent suite.

Code style and development notes
- Keep files small and composable; isolate integration points (YouTube fetch, transcription, LLM calls) behind thin adapters.
- Favor pure functions and dependency injection to allow unit testing without real network/model calls.
- Avoid hard-coding API keys or model names; use environment variables with reasonable defaults.
- For Flask integrations (listed in dependencies):
  - Structure as an app factory (`create_app`) to enable testing via Flask’s test client without running a server.
  - Place routes in blueprints; keep business logic outside route functions for testability.
- Logging: prefer `logging` over prints. For CLI tools (`yt-dlp`), capture and normalize logs for reproducible tests.

Known quirks
- The dependency manifest filename is `requirements.txt`. Some editors or automations may try to rename or reformat it—do not change it without aligning all automation.
- Heavy ML dependencies can make `pip install -r requirements.txt` slow. Use a cached wheelhouse or pin to CPU wheels in CI to speed up.
