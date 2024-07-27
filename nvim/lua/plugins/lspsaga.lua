return {
  'glepnir/lspsaga.nvim',
  config = function()
    require('lspsaga').setup({
      server_filetype_map = {
        typescript = 'typescript'
      }
    })
  end,
}

