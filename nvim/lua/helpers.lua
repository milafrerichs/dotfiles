-- nvim/lua/helpers.lua
local M = {}

-- fern bookmarks
function M.setup_fern_bookmarks()
  -- Open bookmark:///
  vim.api.nvim_set_keymap(
    'n',
    '<Plug>(fern-my-enter-bookmark)',
    ':<C-u>Fern bookmark:///<CR>',
    { noremap = true, silent = true, buffer = true }
  )

  -- Use <expr> mapping to call fern#smart#scheme
  -- This function returns a string that Neovim will execute as a command.
  vim.api.nvim_set_keymap(
    'n',
    '<C-^>',
    "v:lua.require('helpers').fern_smart_scheme_wrapper()", -- Call a Lua wrapper function
    { noremap = true, silent = true, buffer = true, expr = true }
  )
end

-- Wrapper function for fern#smart#scheme for <expr> mapping
function M.fern_smart_scheme_wrapper()
  -- vim.fn['fern#smart#scheme'] calls the Vimscript function
  return vim.fn['fern#smart#scheme']('<Plug>(fern-my-enter-bookmark)', { bookmark = '<C-^>' })
end

return M
