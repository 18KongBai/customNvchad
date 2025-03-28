-- image.nvim 配置
-- 需要安装以下依赖:
-- 1. ImageMagick (必须): brew install imagemagick
-- 2. Kitty (你已经使用Kitty终端)

return {
  backend = "kitty",
  processor = "magick_rock", -- or "magick_cli"
  
  -- 图片显示设置
  max_width = 150, -- 设置更大的尺寸
  max_height = 80,
  max_width_window_percentage = 80,
  max_height_window_percentage = 80,
  render_position = "center", -- 居中显示图片
  
  -- 重要: 防止图片重叠的设置
  window_overlap_clear_enabled = true, -- 启用窗口重叠时清除图像，解决重叠问题
  window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
  clear_in_normal_mode = true, -- 在普通模式下自动清除图片
  auto_clear = true, -- 自动清除旧图片
  clear_on_cursor_display = true, -- 光标移动到图片区域时清除图片
  
  -- 集成设置
  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = true, -- 在插入模式下清除图片
      download_remote_images = true,
      only_render_image_at_cursor = false, -- 设为true可能会减少重叠，但只会显示光标所在的图片
      floating_windows = false,
      filetypes = { "markdown", "vimwiki" },
    },
    neorg = {
      enabled = true,
      clear_in_insert_mode = true, -- 在插入模式下清除图片
      filetypes = { "norg" },
    },
    typst = {
      enabled = true,
      clear_in_insert_mode = true, -- 在插入模式下清除图片
      filetypes = { "typst" },
    },
    html = {
      enabled = false,
    },
    css = {
      enabled = false,
    },
  },
  
  -- 其他设置
  editor_only_render_when_focused = true, -- 仅在编辑器聚焦时渲染
  tmux_show_only_in_active_window = true, -- 仅在活动tmux窗口中显示
  hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
  
  -- 自动刷新设置
  refresh_rate = 5000, -- 5秒自动刷新一次，清除并重新渲染图片
} 