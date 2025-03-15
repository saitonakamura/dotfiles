function hasNoDots(path)
  -- Matches any occurrence of . or .. in the path
  return not path:match("%.%.?")
end

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function(args)
    if vim.fn.argc() == 1 then
      local arg = vim.fn.argv(0)
      if hasNoDots(arg) then
        local path = vim.uv.cwd() .. "/" .. arg
        vim.api.nvim_set_current_dir(path)
      end
    end
  end,
})
