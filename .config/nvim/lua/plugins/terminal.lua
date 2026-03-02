return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("toggleterm").setup({
      direction = "vertical",
      size = function()
        return math.floor(vim.o.columns * 0.25)
      end,
      open_mapping = false,
    })
  end,
  keys = {
    {
      "<leader>oo",
      function()
        local Terminal = require("toggleterm.terminal").Terminal
        local opencode = Terminal:new({
          cmd = "opencode",
          direction = "vertical",
          hidden = false,
          close_on_exit = false,
        })
        opencode:toggle()
      end,
      desc = "Open terminal with opencode",
    },
    {
      "<leader>ot",
      "<cmd>ToggleTerm<cr>",
      desc = "Toggle terminal",
    },
    {
      "<leader>oh",
      function()
        local Terminal = require("toggleterm.terminal").Terminal
        local term = Terminal:new({
          direction = "horizontal",
          size = 20,
          close_on_exit = false,
        })
        term:toggle()
      end,
      desc = "Open horizontal terminal",
    },
    {
      "<leader>ov",
      function()
        local Terminal = require("toggleterm.terminal").Terminal
        local term = Terminal:new({
          direction = "vertical",
          size = math.floor(vim.o.columns * 0.30),
          close_on_exit = false,
        })
        term:toggle()
      end,
      desc = "Open vertical terminal",
    },
    {
      "<leader>of",
      function()
        local Terminal = require("toggleterm.terminal").Terminal
        local term = Terminal:new({
          direction = "float",
          float_opts = {
            border = "curved",
          },
          close_on_exit = false,
        })
        term:toggle()
      end,
      desc = "Open floating terminal",
    },
    {
      "<leader>O",
      function()
        local Terminal = require("toggleterm.terminal").Terminal
        local term = Terminal:new({
          direction = "vertical",
          size = math.floor(vim.o.columns * 0.25),
          close_on_exit = false,
        })
        term:toggle()
      end,
      desc = "Open new terminal instance",
    },
  },
}
