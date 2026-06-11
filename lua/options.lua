require "nvchad.options"

-- 折叠
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- 折叠
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- jkhl 移动时光标周围保留行数
vim.opt.scrolloff = 14
vim.opt.sidescrolloff = 14
vim.opt.cursorline = false

-- 只在 css/scss/less 文件中显示颜色高亮
-- 在 lazy 完成加载后再覆盖 colorify.attach，避免依赖魔法延迟时间
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  once = true,
  callback = function()
    local ok, colorify = pcall(require, "nvchad.colorify")
    if not ok then
      return
    end

    local allowed_ft = { css = true, scss = true, less = true }
    local original_attach = colorify.attach

    colorify.attach = function(buf, event)
      if not allowed_ft[vim.bo[buf].filetype] then
        return
      end
      return original_attach(buf, event)
    end
  end,
})
