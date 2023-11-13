return {
  'glepnir/lspsaga.nvim',
  config = function()
    require('lspsaga').init_lsp_saga {
      server_filetype_map = {
        typescript = 'typescript'
      }
    }
  end,
}

