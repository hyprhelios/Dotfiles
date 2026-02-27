return {
  "sudo-tee/opencode.nvim",
  config = function()
    require("opencode").setup({
      keymap_prefix = "<leader>o",
      ui = {
        position = "right",
        window_width = 0.30,
      },
    })
  end,
}