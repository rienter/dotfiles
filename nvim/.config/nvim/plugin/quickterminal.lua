vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "normal mode in termianl buffer" })
vim.keymap.set("t", "<c-[><c-[>", "<c-\\><c-n>", { desc = "normal mode in termianl buffer" })

local state = {
  quickterm = {
    buf = -1,
    win = -1,
  }
}

local function open_quickterminal(opts)
  opts = opts or {}

  -- Create a new empty buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- Window options
  local win_opts = {
    style = "minimal",
    split = 'below',
    win = 0,
    height = 20,
  }

  -- Open the floating window
  local win = vim.api.nvim_open_win(buf, true, win_opts)

  return { buf = buf, win = win }
end

local toggle_quickterminal = function()
  if not vim.api.nvim_win_is_valid(state.quickterm.win) then
    state.quickterm = open_quickterminal { buf = state.quickterm.buf }
    if vim.bo[state.quickterm.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.quickterm.win)
  end
end

vim.api.nvim_create_user_command("Quickterminal", toggle_quickterminal, {})

-- Example keymap
vim.keymap.set("n", "<space>tt", vim.cmd.Quickterminal, { desc = "[T]oggle Quick [T]erminal" })
