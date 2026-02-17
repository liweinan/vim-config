# LazyVim 使用指南

## 目录
- [基础概念](#基础概念)
- [符号大纲 (Aerial)](#符号大纲-aerial)
- [LSP 功能](#lsp-功能)
- [窗口导航](#窗口导航)
- [文件操作](#文件操作)
- [常用快捷键](#常用快捷键)
- [插件管理](#插件管理)
- [故障排查](#故障排查)

---

## 基础概念

### Leader 键
- `<leader>` 默认是 **空格键**
- 大部分自定义快捷键都以 `<leader>` 开头

### 模式
- **Normal 模式**: 默认模式，用于导航和命令（按 `ESC` 进入）
- **Insert 模式**: 编辑模式（按 `i` 进入）
- **Visual 模式**: 选择模式（按 `v` 进入）
- **Command 模式**: 命令行模式（按 `:` 进入）

---

## 符号大纲 (Aerial)

### 打开/关闭符号大纲
```
<space>a                打开/关闭符号大纲（右侧栏）
:AerialToggle          同上（命令模式）
:AerialInfo            查看 Aerial 状态信息
```

### 在符号大纲中导航
```
j / k                  向下/向上移动
{ / }                  跳转到上一个/下一个符号
[[ / ]]                跳转到上一级/下一级符号
<C-j> / <C-k>          向下/向上移动并滚动预览
```

### 符号操作
```
<CR> (回车)            跳转到符号定义（关闭大纲）
<C-v>                  在垂直分割窗口中打开
<C-s>                  在水平分割窗口中打开
p                      预览符号（不跳转，仅滚动）
```

### 折叠/展开
```
o / za                 展开/折叠当前节点
O / zA                 递归展开/折叠
l / zo                 展开节点
h / zc                 折叠节点
zR                     展开所有节点
zM                     折叠所有节点
```

### 其他
```
q                      关闭符号大纲
?                      显示帮助（所有快捷键）
```

---

## LSP 功能

### 查看 LSP 状态
```
:LspInfo               查看当前文件的 LSP 连接状态
:LspStart asm_lsp      手动启动 LSP（如果未自动启动）
:Mason                 打开 LSP 服务器管理器
```

### 已配置的 LSP
- **clangd**: C/C++ 语言支持
- **asm_lsp**: 汇编语言支持 (.asm, .s, .S)

### 代码导航
```
gd                     跳转到定义 (Goto Definition)
gD                     跳转到声明 (Goto Declaration)
gr                     查找引用 (References)
gI                     跳转到实现 (Goto Implementation)
gy                     跳转到类型定义 (Goto Type Definition)
K                      悬停文档 (Hover)
gK                     签名帮助 (Signature Help)
<C-o>                  返回到跳转前的位置 (Jump Back)
<C-i>                  前进到跳转后的位置 (Jump Forward)
```

### 符号搜索（推荐）
```
<leader>ss             在当前文件中搜索符号 (Document Symbols)
<leader>sS             在整个工作区搜索符号 (Workspace Symbols)
```

**使用场景：**
- 快速跳转到项目中的任何函数、类、变量
- 支持模糊搜索，输入部分名称即可
- 比手动浏览更高效

### 代码操作
```
<leader>ca             代码操作 (Code Action)
<leader>cr             重命名符号 (Rename)
<leader>cf             格式化代码 (Format)
```

### 诊断信息
```
<leader>cd             显示诊断信息 (Diagnostics)
]d                     下一个诊断
[d                     上一个诊断
```

---

## 窗口导航

### 基本窗口切换
```
<C-w>h                 移动到左侧窗口
<C-w>l                 移动到右侧窗口
<C-w>j                 移动到下方窗口
<C-w>k                 移动到上方窗口
<C-w>w                 循环切换窗口
```

### 窗口大小调整
```
<C-w>=                 平均分配窗口大小
<C-w>|                 最大化当前窗口宽度
<C-w>_                 最大化当前窗口高度
<C-w>+                 增加窗口高度
<C-w>-                 减少窗口高度
<C-w>>                 增加窗口宽度
<C-w><                 减少窗口宽度
```

### 窗口分割
```
<C-w>s                 水平分割窗口（上下分割）
<C-w>v                 垂直分割窗口（左右分割）
:split 或 :sp          水平分割当前窗口（命令模式）
:vsplit 或 :vs         垂直分割当前窗口（命令模式）
:split filename        水平分割并打开指定文件
:vsplit filename       垂直分割并打开指定文件
<C-w>c 或 :close       关闭当前窗口
<C-w>q 或 :q           退出当前窗口
<C-w>o 或 :only        只保留当前窗口，关闭其他所有窗口
```

### 窗口大小精细调整
```
:resize +5             增加窗口高度 5 行
:resize -5             减少窗口高度 5 行
:vertical resize +5    增加窗口宽度 5 列
:vertical resize -5    减少窗口宽度 5 列
:resize 20             设置窗口高度为 20 行
:vertical resize 80    设置窗口宽度为 80 列
```

---

## 文件操作

### 文件浏览器 (Neo-tree)
```
<leader>e              打开/关闭文件浏览器
<leader>E              在当前文件位置打开文件浏览器
```

### 文件搜索和跳转 (Telescope)
```
<leader>ff             查找文件 (Find Files) - 模糊搜索文件名
<leader>fg             全局搜索内容 (Grep) - 在文件内容中搜索
<leader>fb             查找缓冲区 (Buffers)
<leader>fr             最近文件 (Recent Files)
<leader>fh             帮助标签 (Help Tags)
<leader>/              在当前文件中搜索
```

**Telescope 操作技巧：**
- 输入文件名的一部分进行模糊匹配
- `<C-j>/<C-k>` 或箭头键上下选择
- `<CR>` 打开文件
- `<C-x>` 在水平分割窗口中打开
- `<C-v>` 在垂直分割窗口中打开
- `<C-t>` 在新标签页中打开

### 直接打开文件（命令模式）
```
:e filename            编辑文件（支持相对路径和绝对路径）
:e src/main.c          示例：打开 src/main.c
:e .                   打开当前目录的文件浏览器
:sp filename           在水平分割窗口中打开文件
:vs filename           在垂直分割窗口中打开文件
```

### 跳转到光标下的文件
```
gf                     跳转到光标下的文件路径
<C-w>f                 在新窗口中打开光标下的文件
<C-w>gf                在新标签页中打开光标下的文件
```

**使用场景：**
- 在 `#include "config.h"` 中，光标放在 `config.h` 上按 `gf`
- 在 import 语句中快速跳转到对应文件
- 在文档中的文件路径上快速打开文件

### 缓冲区管理
```
<leader>bb             切换缓冲区
<leader>bd             删除缓冲区
[b                     上一个缓冲区
]b                     下一个缓冲区
```

### 文件保存/退出
```
:w                     保存文件
:wq 或 :x              保存并退出
:q                     退出
:q!                    强制退出（不保存）
:qa                    退出所有窗口
```

---

## 常用快捷键

### 编辑
```
i                      在光标前插入
a                      在光标后插入
I                      在行首插入
A                      在行尾插入
o                      在下方新建行并插入
O                      在上方新建行并插入
u                      撤销
<C-r>                  重做
dd                     删除当前行
yy                     复制当前行
p                      粘贴
```

### 移动
```
h/j/k/l                左/下/上/右
w                      下一个单词开头
b                      上一个单词开头
e                      单词结尾
0                      行首
^                      行首（非空白字符）
$                      行尾
gg                     文件开头
G                      文件结尾
<C-d>                  向下滚动半页
<C-u>                  向上滚动半页
```

### 搜索
```
/pattern               向下搜索
?pattern               向上搜索
n                      下一个搜索结果
N                      上一个搜索结果
*                      搜索光标下的单词（向下）
#                      搜索光标下的单词（向上）
```

### Visual 模式
```
v                      字符选择模式
V                      行选择模式
<C-v>                  块选择模式
```

### 注释
```
gcc                    注释/取消注释当前行
gc + 移动              注释选中的区域
```

---

## 插件管理

### Lazy 插件管理器
```
:Lazy                  打开插件管理器界面
:Lazy sync             同步插件（安装/更新/清理）
:Lazy install          安装缺失的插件
:Lazy update           更新所有插件
:Lazy clean            清理未使用的插件
:Lazy reload <plugin>  重新加载插件
```

### Mason LSP 管理器
```
:Mason                 打开 LSP/工具管理器
i                      安装（光标在插件上时）
X                      卸载
U                      更新
/                      搜索
q                      退出
```

---

## 故障排查

### LSP 不工作
1. 检查 LSP 状态：`:LspInfo`
2. 检查日志：`:lua vim.cmd('edit ' .. vim.lsp.get_log_path())`
3. 手动启动 LSP：`:LspStart <server_name>`
4. 重启 LSP：`:LspRestart`

### 符号大纲没有内容
1. 检查 LSP 是否连接：`:LspInfo`
2. 检查 Aerial 状态：`:AerialInfo`
3. 确保文件类型正确：`:set filetype?`
4. 对于 .s/.S 文件，应该显示 `filetype=asm`

### 图标显示乱码
1. 确保安装了 Nerd Font：
   ```bash
   brew install --cask font-jetbrains-mono-nerd-font
   ```
2. 在终端设置中选择 "JetBrainsMono Nerd Font Mono"
3. 重启终端

### 配置未生效
1. 重新加载配置：`:source ~/.config/nvim/init.lua`
2. 同步插件：`:Lazy sync`
3. 重启 Neovim：`:qa` 然后重新打开

### 查看日志
```
:checkhealth           健康检查
:messages              查看消息历史
:LspLog                查看 LSP 日志
```

---

## 配置文件位置

```
~/.config/nvim/                      主配置目录
~/.config/nvim/init.lua              入口文件
~/.config/nvim/lua/config/           LazyVim 配置
~/.config/nvim/lua/plugins/          插件配置
~/.config/nvim/lua/plugins/aerial.lua  符号大纲配置
~/.config/nvim/lua/plugins/lsp.lua   LSP 配置
~/.config/nvim/ftdetect/asm.vim      汇编文件类型检测
```

---

## 实用工作流程示例

### 浏览和编辑汇编代码
1. `nvim boot.asm` - 打开文件
2. `<space>a` - 打开符号大纲
3. 用 `j/k` 或 `{/}` 浏览符号
4. `<CR>` - 跳转到目标符号
5. `i` - 进入插入模式编辑
6. `ESC` - 返回 Normal 模式
7. `:w` - 保存
8. `<space>a` - 再次打开符号大纲继续浏览

### 查找和替换
1. `<leader>fg` - 全局搜索
2. 输入搜索内容
3. `<CR>` - 跳转到结果
4. `gd` - 跳转到定义
5. `gr` - 查看所有引用

### 快速定位函数或变量
1. `<leader>ss` - 当前文件符号搜索
2. 输入函数名的一部分（如 "init"）
3. 选择目标符号并跳转
4. 或使用 `<leader>sS` 在整个项目中搜索

### 多文件代码浏览
1. `<leader>ff` - 查找并打开主文件
2. 光标移到 `#include "header.h"` 上，按 `gf` 跳转到头文件
3. 光标移到函数调用上，按 `gd` 跳转到定义
4. `<C-o>` - 返回上一个位置
5. `<C-i>` - 前进到下一个位置
6. `gr` - 查看函数的所有引用

### Git 操作 (lazygit)
1. `<leader>gg` - 打开 lazygit
2. 使用 lazygit 进行 git 操作
3. `q` - 退出 lazygit

---

## 提示和技巧

1. **学习渐进式**: 不需要一次记住所有快捷键，从常用的开始
2. **使用 Which-Key**: 按下 `<leader>` 后稍等片刻，会显示可用的快捷键
3. **自定义配置**: 修改 `~/.config/nvim/lua/plugins/` 下的文件来自定义行为
4. **查看帮助**: `:help <topic>` 查看 Vim 帮助文档
5. **备份配置**: 定期备份你的配置目录

---

## 更多资源

- LazyVim 官方文档: https://www.lazyvim.org/
- Neovim 官方文档: https://neovim.io/doc/
- Aerial.nvim: https://github.com/stevearc/aerial.nvim
- asm-lsp: https://github.com/bergercookie/asm-lsp

---

**最后更新**: 2026-02-17 (添加了符号跳转、文件跳转和详细的窗口分割命令)
