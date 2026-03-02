-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function run_git_cmd(cmd, success_msg, error_prefix)
  local output = vim.fn.system(cmd)
  if vim.v.shell_error == 0 then
    vim.notify(success_msg, vim.log.levels.INFO)
  else
    vim.notify(error_prefix .. ": " .. output, vim.log.levels.ERROR)
  end
end

vim.keymap.set("n", "<leader>gc", function()
  vim.ui.input({ prompt = "Commit message: " }, function(msg)
    if msg and msg ~= "" then
      run_git_cmd({ "git", "commit", "-m", msg }, "Committed: " .. msg, "Git commit failed")
    end
  end)
end, { desc = "Git Commit (with message)" })

vim.keymap.set("n", "<leader>ga", function()
  run_git_cmd("git add -A", "All files staged", "Git add failed")
end, { desc = "Git Add all" })

vim.keymap.set("n", "<leader>gp", function()
  run_git_cmd("git push", "Pushed successfully", "Push failed")
end, { desc = "Git Push" })
