--- @class present.Slides
--- @field slides present.Slide[]: The slides of the file

--- @class present.Slide
--- @field title string: The title of the slide
--- @field body string[]: The body of the slide as a list of lines

--- @class present.WinConfig
--- @field background table: configuration for the background window
--- @field header table: configuration for the title window
--- @field body table: configuration for the window containing the body of the slide
--- @field footer table: configuration for the footer window

--- @type {
--- filename: string,
--- parsed: table,
--- current_slide: integer,
--- floats: present.WinConfig }
local state = {
  filename = "",
  parsed = {},
  current_slide = 0,
  floats = {
    background = {},
    header = {},
    body = {},
    footer = {},
  },
}

--- Takes some lines and turns them into present.Slides
--- @param lines string[]: lines in the buffer
--- @return present.Slides
local parse_slides = function(lines)
  local slides = { slides = {} }
  local current_slide = {
    title = "",
    body = {},
  }
  local separator = "^#"

  for _, line in ipairs(lines) do
    if line:find(separator) then
      if #current_slide.title > 0 then
        table.insert(slides.slides, current_slide)
      end
      current_slide = {
        title = line,
        body = {},
      }
    else
      table.insert(current_slide.body, line)
    end
  end
  table.insert(slides.slides, current_slide)

  return slides
end

--- Create configuration for all windows
--- @return present.WinConfig
local create_window_configuration = function()
  local width = vim.o.columns
  local height = vim.o.lines
  local body_width = 100
  local body_padding = (width - body_width) / 2

  return {
    background = {
      relative = "editor",
      width = width,
      height = height,
      style = "minimal",
      col = 0,
      row = 0,
      border = "none",
      zindex = 1,
    },
    header = {
      relative = "editor",
      width = width,
      height = 1,
      style = "minimal",
      col = 0,
      row = 0,
      border = "rounded",
      zindex = 3,
    },
    body = {
      relative = "editor",
      width = math.min(body_width, width),
      height = height - 8,
      style = "minimal",
      col = body_padding,
      row = 4,
      border = "solid",
      zindex = 2,
    },
    footer = {
      relative = "editor",
      width = width,
      height = 1,
      style = "minimal",
      col = 0,
      row = height - 1,
      border = "none",
      zindex = 3,
    },
  }
end

--- Create a floating window fullscreen to show the presentation
--- @param config table: options for the floating window
--- @return { buf: integer, win: integer }
local create_floating_window = function(config, enter)
  if enter == nil then
    enter = false
  end

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, enter or false, config)

  return { buf = buf, win = win }
end

--- Execute a callback on all the floating windows of the state
--- @param cb function: the callback to call on each window
local foreach_float = function(cb)
  for name, float in pairs(state.floats) do
    cb(name, float)
  end
end

--- Start the presentation and set all autocmds and keybindings
--- @param opts table: table with options for the presentation buffer
local start_presentation = function(opts)
  opts = opts or {}
  opts.bufnr = opts.bufnr or 0

  state.filename = vim.fn.expand("%:t")

  local lines = vim.api.nvim_buf_get_lines(opts.bufnr, 0, -1, false)
  state.parsed = parse_slides(lines)
  state.current_slide = 1

  local windows = create_window_configuration()

  state.floats.background = create_floating_window(windows.background)
  state.floats.header = create_floating_window(windows.header)
  state.floats.body = create_floating_window(windows.body, true)
  state.floats.footer = create_floating_window(windows.footer)

  foreach_float(function(_, float)
    vim.bo[float.buf].filetype = "markdown"
    vim.wo[float.win].conceallevel = 2
    vim.wo[float.win].concealcursor = "n"
  end)
  vim.bo[state.floats.footer.buf].filetype = ""

  --- @param current_slide integer: index of the current slide
  local set_slide_content = function(current_slide)
    local slide = state.parsed.slides[current_slide]
    local padding = string.rep(" ", (vim.o.columns - #slide.title) / 2)
    local title = padding .. slide.title
    local footer = string.format(
      "  %d / %d - %s",
      current_slide,
      #state.parsed.slides,
      state.filename
    )

    vim.api.nvim_buf_set_lines(
      state.floats.header.buf, 0, -1, false, { title }
    )
    vim.api.nvim_buf_set_lines(
      state.floats.body.buf, 0, -1, false, slide.body
    )
    vim.api.nvim_buf_set_lines(
      state.floats.footer.buf, 0, -1, false, { footer }
    )
  end

  set_slide_content(state.current_slide)

  vim.keymap.set('n', 'n', function()
    state.current_slide = math.min(state.current_slide + 1, #state.parsed.slides)
    set_slide_content(state.current_slide)
  end, { buffer = state.floats.body.buf, desc = "Next slide", noremap = true, })

  vim.keymap.set('n', 'p', function()
    state.current_slide = math.max(state.current_slide - 1, 1)
    set_slide_content(state.current_slide)
  end, { buffer = state.floats.body.buf, desc = "Previous slide", noremap = true, })

  local restore = {
    cmdheight = {
      original = vim.o.cmdheight,
      presentation = 0,
    },
    guicursor = {
      original = vim.o.guicursor,
      presentation = "n:NormalFloat",
    }
  }

  for option, config in pairs(restore) do
    vim.opt[option] = config.presentation
  end

  vim.api.nvim_create_autocmd("BufLeave", {
    group = vim.api.nvim_create_augroup("PresentRestore", { clear = true }),
    buffer = state.floats.body.buf,
    callback = function()
      foreach_float(function(_, float)
        pcall(vim.api.nvim_win_close, float.win, true)
      end)
      for option, config in pairs(restore) do
        vim.opt[option] = config.original
      end
    end,
  })

  vim.api.nvim_create_autocmd("VimResized", {
    group = vim.api.nvim_create_augroup("PresentResized", { clear = true }),
    callback = function()
      if not vim.api.nvim_win_is_valid(state.floats.body.win) or state.floats.body.win == nil then
        return
      end

      local updated = create_window_configuration()
      foreach_float(function(name, _)
        vim.api.nvim_win_set_config(state.floats[name].win, updated[name])
      end)

      set_slide_content(state.current_slide)
    end
  })
end

vim.api.nvim_create_user_command("Present", function() start_presentation { slidenr = 1 } end, {})
