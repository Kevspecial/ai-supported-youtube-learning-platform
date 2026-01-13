# Agent Workflow Specification (.md)
# Purpose: Describe high-level goals, inputs, processing steps, and outputs
# the AI agent should follow in this project.
#
# Replace placeholders with your actual workflow definition/schema.

name: AgentWorkflow
version: 0.1

goals:
  - curate_relevant_youtube_content
  - transcribe_and_summarize
  - produce_structured_learning_materials

inputs:
  - youtube_url
  - channel_id
  - max_duration_minutes

steps:
  - fetch_video_metadata
  - download_audio_with_yt_dlp
  - transcribe_with_whisper
  - summarize_with_llm
  - export_markdown_notes

outputs:
  - summary_md
  - key_points_json
  - transcript_vtt

notes:
  - "Keep steps modular; prefer adapters so each step can be tested in isolation."
  - "Avoid invoking heavy models in CI; use fixtures/mocks."
