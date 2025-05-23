return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter', -- Load plugin when entering insert mode
    opts = function()
      return {
        -- Basic autopairs configuration
        check_ts = true, -- Enable treesitter integration
        ts_config = {
          lua = { 'string', 'source' }, -- Treesitter nodes to enable autopairs
          javascript = { 'string', 'template_string' },
          java = false, -- Disable for specific languages if needed
        },
        disable_filetype = { 'TelescopePrompt', 'vim' }, -- Disable for specific filetypes
        fast_wrap = {
          map = '<M-e>', -- Fast wrap keybinding (Alt+e)
          chars = { '{', '[', '(', '"', "'" }, -- Characters to wrap
          pattern = [=[[%'%"%>%]%)%}%,]]=], -- Pattern for fast wrap
          end_key = '$',
          keys = 'qwertyuiopzxcvbnmasdfghjkl', -- Keys for fast wrap selection
          check_comma = true,
          highlight = 'Search', -- Highlight group for wrapped text
          highlight_grey = 'Comment',
        },
      }
    end,
    config = function(_, opts)
      local autopairs = require('nvim-autopairs')
      autopairs.setup(opts)

      -- Optional: Integrate with nvim-cmp if you're using it
      local cmp_status, cmp = pcall(require, 'cmp')
      if cmp_status then
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      end
    end,
  },
}

