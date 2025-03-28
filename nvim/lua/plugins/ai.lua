return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = function(_, opts)
      local github_prompts_m = require("modules.github_prompts")
      local prompts = github_prompts_m.load_prompts()
      if next(prompts) ~= nil then
        opts.prompts = prompts
      end

      opts.model = "claude-3.7-sonnet"
    end,
  },
}
