local options = {
  provider = "deepseek",
  openai = {
    endpoint = "https://api.openai.com/v1",
    model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
    timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
    temperature = 0,
    max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
    --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
  },
  vendors = {
    deepseek = {
      __inherited_from = "openai",
      api_key_name = "DEEPSEEK_API_KEY",
      endpoint = "https://api.deepseek.com",
      model = "deepseek-coder",
    },
  },
}

return options
