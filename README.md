# NvChad custom config

## 目录

``` javascript
./custom
├── plugins                                // 客制化插件
│   ├── configs                            //插件对应配置文件目录
│   ├── init.lua                           // packer安装对应插件
│   ├── overrides.lua                      // 覆盖nvchad对应插件配置
│   └── ......
├── init.lua
├── chadrc.lua                           // 整合客制化配置项
└── mappings.lua                         // 客制化插件对应键位
```

## 使用 v2.0版本

``` javascript
1. cd ~/.config
2. git clone https://github.com/NvChad/NvChad.git
3. mv Nvchad nvim
4. 切换为v2.0版本
5. cd ~/.config/nvim/lua
6. git clone https://github.com/18KongBai/customNvchad.git
7. mv customNvchad custom
8. 切换为v2.0版本
9. nvim
```

## mason安装配套lsp `:Mason`

- css-lsp
- emmet-ls
- eslint_d
- fixjson
- html-lsp
- json-lsp
- lua-language-server
- markdownlint
- prettierd
- stylelint-lsp
- typescript-language-server
- vetur-vls
- vim-language-server
- vtsls
- vue-language-server

> 当mason列表没有安装以上相对应的插件，即可使用:MasonInstallAll 手动安装以上lsp

## nvim-treesitter 高亮语法安装列表 `:TSInstallInfo`

- css
- html
- javascript
- json
- lua
- markdown
- markdown_inline
- tsx
- typescript
- vim
- vue

## 插件配置使用说明

### markdown preview 插件使用

``` javascript
cd ~/.local/share/nvim/site/pack/packer/start/
git clone https://github.com/iamcco/markdown-preview.nvim.git
cd markdown-preview.nvim
yarn install
yarn build
```
