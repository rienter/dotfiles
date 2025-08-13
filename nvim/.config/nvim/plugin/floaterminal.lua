vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "normal mode in termianl buffer" })

local state = {
	floating = {
		buf = -1,
		win = -1,
	}
}

local function open_floaterminal(opts)
	opts = opts or {}

	-- Get the current editor size
	local columns = vim.o.columns
	local lines = vim.o.lines

	-- Calculate window size (50% of terminal size)
	local width = math.floor(columns * 0.5)
	local height = math.floor(lines * 0.5)

	-- Calculate position to center it
	local col = math.floor((columns - width) / 2)
	local row = math.floor((lines - height) / 2)

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
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		border = "rounded"
	}

	-- Open the floating window
	local win = vim.api.nvim_open_win(buf, true, win_opts)

	return { buf = buf, win = win }
end

local toggle_floaterminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = open_floaterminal { buf = state.floating.buf }
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

vim.api.nvim_create_user_command("Floaterminal", toggle_floaterminal, {})

-- Example keymap
vim.keymap.set("n", "<space>tt", vim.cmd.Floaterminal, { desc = "Toggle floating Terminal" })
