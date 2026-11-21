-- Craftzdog + Void-macOS-OLED Layer for Official LazyVim
return {
  -- Set Void-macOS-OLED (matching Ghostty) as LazyVim's active colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "void-oled",
    },
  },

  -- Treesitter: ensure all key parsers are installed
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "css",
        "dockerfile",
        "fish",
        "html",
        "java",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      })
    end,
  },

  -- Craftzdog floating filename badge (top-right of each window)
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    priority = 1200,
    config = function()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = "#ff8c38", guifg = "#060608" },
            InclineNormalNC = { guifg = "#a1a1aa", guibg = "#121216" },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = { cursorline = true },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then filename = "[No Name]" end
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end
          local ok, devicons = pcall(require, "nvim-web-devicons")
          local icon, color = "", nil
          if ok then
            icon, color = devicons.get_icon_color(filename)
          end
          return { { icon or "", guifg = props.focused and "#060608" or color }, { " " }, { filename } }
        end,
      })
    end,
  },

  -- Lualine styled in Ghostty's exact Void-macOS-OLED transparent palette
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.theme = {
        normal = {
          a = { fg = "#060608", bg = "#ff8c38", gui = "bold" },
          b = { fg = "#ededf0", bg = "#141418" },
          c = { fg = "#a1a1aa", bg = "NONE" },
        },
        insert = {
          a = { fg = "#060608", bg = "#34d399", gui = "bold" },
        },
        visual = {
          a = { fg = "#060608", bg = "#c084fc", gui = "bold" },
        },
        replace = {
          a = { fg = "#060608", bg = "#ff5f56", gui = "bold" },
        },
        command = {
          a = { fg = "#060608", bg = "#60a5fa", gui = "bold" },
        },
        inactive = {
          a = { fg = "#71717a", bg = "#0c0c10" },
          b = { fg = "#71717a", bg = "#0c0c10" },
          c = { fg = "#52525b", bg = "NONE" },
        },
      }
      opts.options.component_separators = { left = "│", right = "│" }
      opts.options.section_separators = { left = "", right = "" }
    end,
  },

  -- Clean minimal Bufferline tabs (Craftzdog style)
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = "thin",
      },
    },
  },
}
