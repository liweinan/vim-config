# Neovim：软折行、Python 跳转与窗口切换

本文整理自常用操作说明，可与根目录 [USAGE_GUIDE.md](./USAGE_GUIDE.md) 对照使用。

---

## 1. 软折行（Soft wrap）

软折行只影响**显示**，不会在文件里插入真正的换行符。

### 相关选项（已在 `lua/config/options.lua` 中可配置）

| 选项 | 作用 |
|------|------|
| `wrap` | 打开软折行 |
| `linebreak` | 尽量在空白处断行，减少单词中间被切断 |
| `breakindent` | 续行保持与上一行相近的缩进 |

### 与硬换行的区别

- **软折行**：`wrap` 等，缓冲区里仍是一行。
- **硬换行**：`textwidth`、`gq`、`formatoptions` 等会在文本中插入换行符。

### 仅当前窗口

```vim
setlocal wrap linebreak breakindent
```

---

## 2. Python：跳到定义 / “实现”

在 Neovim 里装好 Python LSP（常见为 **Pyright** / **basedpyright**）后，最常用的是 **跳到定义**（`textDocument/definition`）。

### 基本操作

1. 光标放在**符号名**上（例如 `infer` 的字母上，不要放在 `await`、`(` 上）。
2. 按 **`gd`**（或你配置里绑定的 LSP「Go to Definition」）。
3. 底层等价：`:lua vim.lsp.buf.definition()`。

### 从 `import` 跟到具体文件

例如：

```python
from services.inference import infer
```

- 光标在 **`infer`** 上按 **`gd`**：通常直接进入 **`infer` 所在文件**（即 `services/inference.py` 里函数定义）。
- 光标在 **`inference`**（模块名）上按 **`gd`**：通常打开 **`services/inference.py`**（模块本身）。

若第一次 **`gd`** 只停在 **import 行**的符号上，**光标保持在该符号上再按一次 `gd`**，一般会进入实际模块/函数定义。

### LSP 的「实现」(implementation)

`vim.lsp.buf.implementation()` 在 Python 上支持有限，日常以 **definition（`gd`）** 为主。

### 跳不过去时

- 用 `:LspInfo` 确认 Python 语言服务正常。
- 确认 LSP 使用的 **Python / venv** 与项目一致，且依赖已安装（否则第三方库可能无法解析）。
- 动态绑定（如 `getattr`）可能无法静态跳转，需用全文搜索等。

### `gf` 与 Python 模块名

**`gf`** 依赖光标下像「文件路径」的文本；`services.inference` 这类**点分模块名**往往不能可靠映射到磁盘路径。Python 项目里更稳的是 **`gd`** 或 **`:e path`** / 文件树。

---

## 3. 示例：跳到 `inference.py`

代码中有：

```python
result = await infer(request.message, session_id_str)
```

或：

```python
from services.inference import infer
```

**推荐**：光标在 **`infer`** 或 **`inference`** 上，按 **`gd`**，由 LSP 打开 `services/inference.py`。

**不依赖 LSP**：在文件树中打开 `services/inference.py`，或 `:e services/inference.py`（路径相对项目根）。

---

## 4. 从编辑区切到文件浏览器（再切回来）

当前环境文档中为 **LazyVim v8 + Snacks Explorer**（见 `USAGE_GUIDE.md`「文件浏览器」一节）。

### 打开 / 关闭侧栏

| 快捷键 | 作用 |
|--------|------|
| `<leader>e` | 打开/关闭文件浏览器（**项目根**，`<leader>` 多为空格） |
| `<leader>E` | 打开/关闭文件浏览器（**当前工作目录**） |

侧栏内常用：**`l`** 打开、**`h`** 收起目录、**`q`** 关闭。

### 在「代码窗口」和「侧栏」之间移动焦点

Vim 标准**窗口**切换（文件树在左、编辑区在右时）：

| 操作 | 作用 |
|------|------|
| `Ctrl+w` 然后 `h` | 焦点移到左侧窗口（多为文件树） |
| `Ctrl+w` 然后 `l` | 焦点移到右侧窗口（多为代码） |
| `Ctrl+w` `w` | 在窗口间循环切换 |
| `Ctrl+w` `p` | 回到上一个窗口 |

先按 **`Ctrl+w`**，松开后再按 **`h` / `l`** 等第二键。

---

## 5. 相关配置文件

| 路径 | 说明 |
|------|------|
| `lua/config/options.lua` | 全局选项（含 `wrap` 等） |
| `lua/config/keymaps.lua` | 自定义按键 |
| `USAGE_GUIDE.md` | 完整使用指南（含 Snacks Picker、Explorer 等） |
