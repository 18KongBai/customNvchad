# NvChad custom config

## 目录

```javascript
nvim
├── lua
├		├── configs 插件对应的配置文件
├		├── plugins 自定义插件安装
├		├── chadrc.lua 覆盖nvchad的配置
├		├── mappings.lua 按键映射
├		├── options neovim 配置
├── init.lua 入口文件
```

## 先决条件

>- [Neovim 0.9.5](https://github.com/neovim/neovim/releases/tag/v0.9.5).
>- [Nerd Font](https://www.nerdfonts.com/) Nerd Font 作为您的终端字体。
>  - 确保您设置的 nerd 字体不以 Mono 结尾，以防止出现小图标。
>  - 示例：JetbrainsMono Nerd 字体而不是 JetbrainsMono Nerd Font Mono
>- 使用 Telescope 进行 grep 搜索需要 [Ripgrep](https://github.com/BurntSushi/ripgrep)（可选）。
>- GCC、Windows 用户必须安装 [`mingw`](http://mingw-w64.org/downloads) 并在路径上进行设置。
>- Make，Windows 用户必须安装 [`GnuWin32`](https://gnuwin32.sourceforge.net/install.html) 并在路径上进行设置。
>- 删除旧的 neovim 文件夹（检查下面的命令）
>  

## Uninstall

```
# Linux / Macos (unix)
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim

# Windows CMD
rd -r ~\AppData\Local\nvim
rd -r ~\AppData\Local\nvim-data

# Window PowerShell
rm -Force ~\AppData\Local\nvim
rm -Force ~\AppData\Local\nvim-data

```

## 使用

```javascript
1. rm -rf ~/.config/nvim
2. rm -rf ~/.local/share/nvim 
3. git clone https://github.com/18KongBai/customNvchad.git ~/.config/nvim && nvim
```

## Update 更新

- `Lazy sync` 命令

## 官方文档

> [Nvchad](https://nvchad.com/docs/quickstart/install)

## mason 安装配套 lsp `:Mason`

> 可使用:Mason 进入界面后 手动安装lsp

## nvim-treesitter 高亮语法安装列表 `:TSInstallInfo`

> 可使用:TSInstallI xxxx 手动安装对应的解析器

## 插件配置使用说明

### ：Lazy  进入插件管理界面，可以进行插件管理 U 可进行更新
