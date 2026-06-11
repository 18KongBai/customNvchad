require "nvchad.autocmds"

-- NvChad 的 LSP on_attach 会注册 buffer 级的 <leader>wa/wr/wl（workspace folder 操作），
-- 导致代码文件里 <leader>w 保存要等 timeoutlen 超时；这些功能用不到，attach 后删掉
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.schedule(function()
      for _, lhs in ipairs { "<leader>wa", "<leader>wr", "<leader>wl" } do
        pcall(vim.keymap.del, "n", lhs, { buffer = args.buf })
      end
    end)
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufDelete", "FileType" }, {
  callback = function(args)
    if args.event == "FileType" then
      vim.o.showtabline = vim.bo.ft == "nvdash" and 0 or 2
      return
    end

    local buf = args.buf

    if not vim.bo[buf].buflisted then
      return
    end

    vim.schedule(function()
      if #vim.t.bufs == 1 and vim.api.nvim_buf_get_name(buf) == "" then
        -- 终端较窄时(如 cmux),nvdash 计算出的光标列可能为负数,
        -- nvim_win_set_cursor 会抛出 "Column value outside range",这里临时钳到 0
        local set_cursor = vim.api.nvim_win_set_cursor
        vim.api.nvim_win_set_cursor = function(w, pos)
          if pos and type(pos[2]) == "number" and pos[2] < 0 then
            pos[2] = 0
          end
          return set_cursor(w, pos)
        end

        pcall(vim.cmd, "Nvdash")

        vim.api.nvim_win_set_cursor = set_cursor
      end
    end)
  end,
})
