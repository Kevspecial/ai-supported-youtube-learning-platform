# Agent Policies Specification (.md)
# Purpose: Define safety, behavior, and runtime policy defaults for the AI agent.
#
# Instructions:
# - Replace sample keys with your actual schema/fields expected by the agent.
# - Keep this file small and text-based so it remains reviewable in code review.
# - If you decide to store large/binary spec assets, configure Git LFS appropriately.
#
# Example keys (edit/remove as appropriate):
name: AgentPolicies
version: 0.1

policies:
  - allow_youtube_download: true
  - max_concurrent_downloads: 2
  - transcription_model: whisper-large-v3
  - summarization_provider: openai
  - respect_rate_limits: true

constraints:
  - no_private_data_exfiltration
  - adhere_to_platform_terms
  - avoid_heavy_models_in_unit_tests
