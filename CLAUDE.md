# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 仓库概览

基于 NvChad v2.5 的自定义 Neovim 配置（NvChad 以插件形式引入，非 fork）。主要面向前端开发：TypeScript/JavaScript、React、Vue、Tailwind、CSS Modules。LSP 配置使用 `vim.lsp.enable` / `vim.lsp.config` 新 API，需要 Neovim 0.11+。

## 常用命令

- `stylua lua/` — 格式化 Lua 代码。规则见 `.stylua.toml`：2 空格缩进、120 列宽、`call_parentheses = "None"`（无括号调用风格，如 `require "configs.lazy"`）、偏好双引号。
- `nvim --headless "+Lazy! sync" +qa` — 同步插件到 `lazy-lock.json` 锁定版本。
- 验证配置改动：启动 `nvim` 观察报错，或用 `:Lazy`（插件状态）、`:Mason`（LSP/格式化工具）、`:checkhealth`。
- `lazy-lock.json` 是插件锁文件，更新插件后应随改动一并提交。

## 架构

加载链路（`init.lua`）：bootstrap lazy.nvim → 加载 NvChad v2.5（`import = "nvchad.plugins"`）和自定义插件（`import = "plugins"`）→ dofile base46 主题缓存 → `require "options"` / `require "autocmds"` → `vim.schedule` 延迟加载 `mappings`。

- `lua/plugins/init.lua` — **所有**自定义插件 spec 集中在这一个文件。
- `lua/configs/*.lua` — 较大的插件配置拆成独立模块，在 spec 中通过 `opts = function() return require "configs.xxx" end` 或 `config` 函数引用。
- `lua/chadrc.lua` — NvChad UI / base46 主题配置（当前主题 chadracula、透明背景）。结构必须与 NvChad 的 `nvconfig.lua` 保持一致。
- `lua/options.lua` / `lua/autocmds.lua` / `lua/mappings.lua` — 均先 `require` NvChad 对应默认模块，再追加自定义内容。自定义按键统一放 `mappings.lua`（leader 为空格）。
- `lua/nvdash.lua` — dashboard 按钮定义，被 `chadrc.lua` 引用。

## 关键约定与坑

- **插件默认懒加载**：`configs/lazy.lua` 中 `defaults = { lazy = true }`。新增插件 spec 必须提供 `event` / `cmd` / `keys` / `ft` 触发器，否则插件不会加载。
- **补全引擎是 blink.cmp，没有安装 nvim-cmp**：任何依赖 `require "cmp"` 的插件配置都会报错（如 windsurf.nvim 必须 `enable_cmp_source = false`）。
- **覆盖 NvChad 内置插件**（telescope、nvim-tree、mason、treesitter、blink.cmp 等）：在 `lua/plugins/init.lua` 写同名 spec，用 `opts = function(_, opts)` 修改已有 opts，而不是整体替换。
- **新增 LSP server**：在 `configs/lspconfig.lua` 的 `servers` 列表加入 server 名（由 `vim.lsp.enable` 启用），同时在 `lua/plugins/init.lua` 的 mason `ensure_installed` 加对应包名。
- **格式化**：由 conform.nvim 在保存后异步执行（`format_after_save`），各文件类型的格式化器在 `configs/conform.lua` 的 `formatters_by_ft` 中配置。
- 代码注释与按键 `desc` 使用中文，是本仓库既有惯例。
