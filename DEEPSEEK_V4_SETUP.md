# DeepSeek V4 配置指南

本仓库同时集成了 **OpenCode** 和 **Claude Code** 两种 AI 编程工具，均指向 DeepSeek V4 模型。

## 前置条件

1. 注册 [DeepSeek 平台](https://platform.deepseek.com/) 并创建 API Key
2. 已安装 [OpenCode](https://opencode.ai/download) (>= v1.14.24)
3. 已安装 [Claude Code](https://docs.anthropic.com/en/docs/claude-code)

## API Key 设置

两个工具共用同一个环境变量 `DEEPSEEK_API_KEY`（Fish shell）：

```fish
set -Ux DEEPSEEK_API_KEY "sk-你的deepseek-api-key"
```

- `-U`：持久化存储，重启终端后依然有效
- `-x`：导出为环境变量，子进程可读取
- 密钥用**单引号**包裹，避免 fish 插入特殊字符

如需删除：`set -eU DEEPSEEK_API_KEY`

---

## 1. OpenCode + DeepSeek V4

### 配置文件

OpenCode 采用**分层合并**机制：全局配置 + 项目配置。

| 层级 | 路径 | 内容 |
|------|------|------|
| 全局 | `~/.config/opencode/opencode.json` | DeepSeek API Key（env 占位符）+ Zen 备用 |
| 项目 | `opencode/opencode.json` | 模型选择、子模型、推理参数 |

### 全局配置 `~/.config/opencode/opencode.json`

```json
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "opencode": {
      "options": {
        "apiKey": "{env:OPENCODE_ZEN_API_KEY}"
      }
    },
    "deepseek": {
      "options": {
        "apiKey": "{env:DEEPSEEK_API_KEY}"
      }
    }
  }
}
```

- `{env:DEEPSEEK_API_KEY}` 会在运行时被替换为环境变量的实际值
- 密钥**不会**写入文件，安全性由环境变量保证

### 项目配置 `opencode/opencode.json`

```json
{
  "$schema": "https://opencode.ai/config.json",
  "model": "deepseek/deepseek-v4-pro",
  "small_model": "deepseek/deepseek-v4-flash",
  "autoupdate": true,
  "enabled_providers": ["deepseek"],
  "model_params": {
    "reasoning_effort": "max",
    "thinking": {"type": "enabled"}
  }
}
```

| 参数 | 值 | 说明 |
|------|------|------|
| `model` | `deepseek/deepseek-v4-pro` | 主模型，DeepSeek V4 Pro（输入 $0.28/M token） |
| `small_model` | `deepseek/deepseek-v4-flash` | 子模型，用于标题生成等轻量任务（输入 $0.14/M token） |
| `reasoning_effort` | `max` | 最大思维链强度，开启深度推理 |
| `thinking` | `enabled` | 启用思考模式（默认已启用，显式声明更安全） |

### 使用方式

```bash
cd /path/to/project
opencode
```

启动后可用以下命令：
- `/connect` — 连接/切换 Provider
- `/models` — 切换模型
- `/help` — 查看帮助

### 模型切换

如需在 DeepSeek 和 Zen 之间切换，修改 `opencode/opencode.json` 中的 `enabled_providers`：

```json
// 仅 DeepSeek
"enabled_providers": ["deepseek"]

// 仅 Zen  
"enabled_providers": ["opencode"]

// 两者都可用（启动时选择）
"enabled_providers": ["deepseek", "opencode"]
```

---

## 2. Claude Code + DeepSeek V4

### 架构说明

Claude Code 原生使用 Anthropic API。DeepSeek 提供了 **Anthropic API 兼容端点** (`https://api.deepseek.com/anthropic`)，通过环境变量直接将 Claude Code 路由到 DeepSeek V4。

```
Claude Code ──（Anthropic API 协议）──> https://api.deepseek.com/anthropic ──> DeepSeek V4
```

### 环境变量配置

Fish shell 自动加载脚本：`~/.config/fish/conf.d/deepseek-claude.fish`

```fish
# DeepSeek V4 configuration for Claude Code
# Set your API key before using:
#   set -Ux DEEPSEEK_API_KEY "sk-xxxxxxxxxxxxxxxx"

if set -q DEEPSEEK_API_KEY
    set -gx ANTHROPIC_BASE_URL "https://api.deepseek.com/anthropic"
    set -gx ANTHROPIC_AUTH_TOKEN "$DEEPSEEK_API_KEY"
    set -gx ANTHROPIC_MODEL "deepseek-v4-pro"
    set -gx ANTHROPIC_DEFAULT_OPUS_MODEL "deepseek-v4-pro"
    set -gx ANTHROPIC_DEFAULT_SONNET_MODEL "deepseek-v4-pro"
    set -gx ANTHROPIC_DEFAULT_HAIKU_MODEL "deepseek-v4-flash"
    set -gx CLAUDE_CODE_SUBAGENT_MODEL "deepseek-v4-flash"
    set -gx CLAUDE_CODE_EFFORT_LEVEL "max"
end
```

| 环境变量 | 值 | 说明 |
|----------|------|------|
| `ANTHROPIC_BASE_URL` | `https://api.deepseek.com/anthropic` | Anthropic 兼容 API 端点 |
| `ANTHROPIC_AUTH_TOKEN` | `$DEEPSEEK_API_KEY` | 复用 DeepSeek API Key |
| `ANTHROPIC_MODEL` | `deepseek-v4-pro` | 默认模型（1M 上下文） |
| `ANTHROPIC_DEFAULT_OPUS_MODEL` | `deepseek-v4-pro` | Opus 映射到 V4 Pro |
| `ANTHROPIC_DEFAULT_SONNET_MODEL` | `deepseek-v4-pro` | Sonnet 映射到 V4 Pro |
| `ANTHROPIC_DEFAULT_HAIKU_MODEL` | `deepseek-v4-flash` | Haiku 映射到 V4 Flash |
| `CLAUDE_CODE_SUBAGENT_MODEL` | `deepseek-v4-flash` | 子 Agent 使用 Flash（更快更便宜） |
| `CLAUDE_CODE_EFFORT_LEVEL` | `max` | 最大推理强度 |

### 使用方式

设置 API Key 后重新打开终端（或执行 `exec fish`），然后：

```bash
cd /path/to/project
claude
```

### 验证配置

```bash
# 确认环境变量已生效
env | grep ANTHROPIC

# 应输出类似：
# ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
# ANTHROPIC_MODEL=deepseek-v4-pro
# ...
```

### 项目级设置

本项目的 `.claude/settings.local.json` 可配置权限等，不涉及模型路由：

```json
{
  "permissions": {
    "allow": [
      "Bash(git add ...)",
      ...
    ]
  }
}
```

---

## 3. 两个工具对比

| 维度 | OpenCode + V4 | Claude Code + V4 |
|------|---------------|-------------------|
| 协议 | OpenAI 兼容 API（`api.deepseek.com`） | Anthropic 兼容 API（`api.deepseek.com/anthropic`） |
| 费用 | 仅 API 费（$0.28/M 起） | 仅 API 费（$0.28/M 起） |
| 配置方式 | JSON 文件分层合并 | 环境变量路由 |
| 思维链 | `reasoning_effort: max` + `thinking: enabled` | `CLAUDE_CODE_EFFORT_LEVEL=max` |
| API Key | `DEEPSEEK_API_KEY`（通过 config 占位符引用） | `DEEPSEEK_API_KEY`（通过 fish 脚本注入） |
| 适合场景 | 深度推理、灵活配置 | 稳定强大、体验流畅 |

---

## 4. 模型与定价

来源：[DeepSeek Models & Pricing](https://api-docs.deepseek.com/quick_start/pricing)

| 模型 | 输入价格 | 输出价格 | 上下文 | 备注 |
|------|----------|----------|--------|------|
| `deepseek-v4-pro` | $0.28/M | $0.84/M | 1M | Pro 版，主模型 |
| `deepseek-v4-flash` | $0.14/M | $0.42/M | 1M | Flash 版，轻量任务 |
| `deepseek-chat` | — | — | — | 将于 2026/07/24 废弃 |
| `deepseek-reasoner` | — | — | — | 将于 2026/07/24 废弃 |

---

## 5. 故障排查

### 环境变量未生效

```fish
# 检查是否设置
echo $DEEPSEEK_API_KEY

# 手动加载 Claude Code 配置
source ~/.config/fish/conf.d/deepseek-claude.fish

# 确认 ANTHROPIC 变量
env | grep ANTHROPIC
```

### OpenCode 无法连接 DeepSeek

```bash
# 确认全局配置存在
cat ~/.config/opencode/opencode.json | python3 -m json.tool

# 在 opencode 中执行
/connect deepseek
```

### Claude Code 报模型错误

DeepSeek Anthropic API 遇到不支持的模型名会自动降级为 `deepseek-v4-flash`。确保：
- 使用 `deepseek-v4-pro` 或 `deepseek-v4-flash`
- 不要使用已废弃的 `deepseek-chat` 或 `deepseek-reasoner`

### API Key 泄漏处理

若密钥曾泄露：
1. 到 [DeepSeek Platform](https://platform.deepseek.com/api_keys) 作废旧 key
2. 创建新 key
3. 重新执行 `set -Ux DEEPSEEK_API_KEY "sk-新key"`

---

## 6. 参考链接

- [DeepSeek API 文档](https://api-docs.deepseek.com/)
- [DeepSeek + Claude Code 集成指南](https://api-docs.deepseek.com/guides/coding_agents#integrate-with-claude-code)
- [DeepSeek + OpenCode 集成指南](https://api-docs.deepseek.com/guides/coding_agents#integrate-with-opencode)
- [DeepSeek Anthropic API](https://api-docs.deepseek.com/guides/anthropic_api)
- [DeepSeek 思考模式](https://api-docs.deepseek.com/guides/thinking_mode)
- [OpenCode 配置文档](https://opencode.ai/docs/en/config)
- [OpenCode Providers](https://opencode.ai/docs/en/providers)

---

**最后更新**: 2026-04-26
