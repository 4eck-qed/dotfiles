-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

-- configure treesitter
treesitter.setup({
  -- enable syntax highlighting
  highlight = {
    enable = true,
  },
  -- enable indentation
  indent = { enable = true },
  -- enable autotagging (w/ nvim-ts-autotag plugin)
  autotag = { enable = true },
  -- ensure these language parsers are installed
  ensure_installed = {
    "bash",
    "css",
    "dockerfile",
    "gitignore",
    "graphql",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "scss",
    "svelte",
    "tsx",
    "typescript",
    "vim",
    "yaml",
  },
  -- auto install above language parsers
  auto_install = true,
  context_commentstring = {
    enable = true,
    commentary_integration = {
      -- change default mapping
      Commentary = 'g/',
      -- disable default mapping
      CommentaryLine = false,
    },
  },
})
