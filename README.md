# Neovim Configuration

个人 Neovim 配置，基于 [LazyVim](https://github.com/LazyVim/LazyVim)。

## 特性

- 基于 LazyVim 的现代化配置
- 自定义 aerial.nvim 配置，使用 Nerd Font 图标
- LSP、自动补全、语法高亮等开箱即用
- 支持汇编文件语法识别
- 优化的快捷键映射

## 前置要求

- Neovim >= 0.9.0
- Git
- [Nerd Font](https://www.nerdfonts.com/) 字体（推荐 0xProto Nerd Font）
- ripgrep（可选，用于更好的搜索体验）
- fd（可选，用于更快的文件查找）

## 安装

### 首次安装

```bash
# 备份现有配置（如果有）
mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d)
mv ~/.local/share/nvim ~/.local/share/nvim.backup.$(date +%Y%m%d)

# 克隆配置
git clone git@github.com:liweinan/vim-config.git ~/.config/nvim

# 启动 Neovim（插件会自动安装）
nvim
```

首次启动时，LazyVim 会自动安装所有插件。请等待安装完成。

### 在其他机器上同步

```bash
# 1. 克隆配置到新机器
git clone git@github.com:liweinan/vim-config.git ~/.config/nvim

# 2. 启动 Neovim
nvim

# 插件会自动安装，无需手动操作
```

## 更新配置

### 在当前机器提交更改

```bash
cd ~/.config/nvim

# 查看修改
git status
git diff

# 提交更改
git add .
git commit -m "描述你的修改"
git push
```

### 在其他机器拉取更新

```bash
cd ~/.config/nvim

# 拉取最新配置
git pull

# 在 Neovim 中同步插件（如果需要）
# 打开 nvim 后执行：
# :Lazy sync
```

## 主要插件

- **aerial.nvim**: 代码大纲，使用 `<leader>a` 打开
- **nvim-lspconfig**: LSP 支持
- **nvim-treesitter**: 语法高亮和代码理解
- **telescope.nvim**: 模糊查找
- **which-key.nvim**: 快捷键提示

## 快捷键

### 插件快捷键

- `<leader>a` - 打开/关闭 Aerial 代码大纲
- `<leader>ca` - 同上
- 更多快捷键参考 LazyVim 文档或在 Neovim 中按 `<leader>` 查看

### 标签页操作

**打开新标签页:**
- `:tabnew` - 打开空白标签页
- `:tabedit <文件名>` 或 `:tabe <文件名>` - 在新标签页中打开文件

**标签页导航:**
- `gt` - 切换到下一个标签页
- `gT` - 切换到上一个标签页
- `{数字}gt` - 切换到第N个标签页（例如 `2gt` 跳转到第2个）
- `:tabn` - 下一个标签页
- `:tabp` - 上一个标签页

**标签页管理:**
- `:tabclose` 或 `:tabc` - 关闭当前标签页
- `:tabonly` - 关闭除当前外的所有标签页
- `:tabs` - 列出所有标签页

## 自定义配置

所有自定义配置在以下目录：

- `lua/config/` - 基础配置（选项、快捷键、自动命令）
- `lua/plugins/` - 插件配置

修改后推送到 GitHub：

```bash
cd ~/.config/nvim
git add .
git commit -m "Update configuration"
git push
```

## 目录结构

```
~/.config/nvim/
├── init.lua              # 入口文件
├── lazy-lock.json        # 插件版本锁定
├── lua/
│   ├── config/          # 基础配置
│   │   ├── autocmds.lua # 自动命令
│   │   ├── keymaps.lua  # 快捷键
│   │   ├── lazy.lua     # Lazy.nvim 配置
│   │   └── options.lua  # Neovim 选项
│   └── plugins/         # 插件配置
│       ├── aerial.lua   # Aerial 配置
│       ├── lsp.lua      # LSP 配置
│       └── ...
├── ftdetect/            # 文件类型检测
└── README.md            # 本文档
```

## 故障排查

### 插件未自动安装

```vim
" 在 Neovim 中执行
:Lazy sync
```

### 字体图标显示异常

确保终端使用的是 Nerd Font 字体：

1. 下载安装 [Nerd Font](https://www.nerdfonts.com/)
2. 在终端设置中选择 Nerd Font 字体
3. 推荐使用 0xProto Nerd Font

### LSP 不工作

```vim
" 检查 LSP 状态
:LspInfo

" 安装语言服务器
:Mason
```

## 参考

- [LazyVim 文档](https://lazyvim.github.io/)
- [Neovim 文档](https://neovim.io/doc/)
