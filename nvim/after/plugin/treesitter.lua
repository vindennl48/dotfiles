require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "c", "vim", "vimdoc", "query", "python",
    "bash", "cmake", "comment", "cpp", "css", "csv",
    "git_config", "git_rebase", "gitcommit", "gitignore",
    "gitattributes", "gpg", "html", "java", "javascript",
    "json", "json5", "JSON with comments",
    "lua", "luadoc", "make",
    "ruby", "scss", "sql", "ssh_config", "xml", "yaml",
  },

  ignore_install = {
    "json5", "JSON with comments",
  },

  sync_install = true,

  auto_install = true,

  highlight = {
    enable = true,
    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {},
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
