return {
  "simeji/winresizer",
  config = function()
    -- Enable winresizer (default is 1, so optional)
    vim.g.winresizer_enable = 1

    -- If you want to start window resize mode by `Ctrl+T` instead of default `Ctrl+E`
    vim.g.winresizer_start_key = "<leader>ws"

    -- If you want to cancel and quit window resize mode by `z` (keycode 122)
    vim.g.winresizer_keycode_cancel = 122

    -- To expand your window size toward upper using upper arrow (instead of k)
    vim.g.winresizer_keycode_up = "<UP>"
    -- To expand your window size toward lower using down arrow (instead of j)
    vim.g.winresizer_keycode_down = "<DOWN>"

    -- Adjust resize increments
    vim.g.winresizer_vert_resize = 5 -- Resize by 5 columns horizontally
    vim.g.winresizer_horiz_resize = 2 -- Resize by 2 lines vertically
  end,
}
