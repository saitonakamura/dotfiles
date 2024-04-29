return {
  { "nvim-neotest/neotest-plenary" },
  { "marilari88/neotest-vitest" },
  { "nvim-neotest/neotest-jest" },
  {
    "nvim-neotest/neotest",
    opts = { adapters = { "neotest-plenary", "neotest-vitest", "neotest-jest" } },
  },
}
