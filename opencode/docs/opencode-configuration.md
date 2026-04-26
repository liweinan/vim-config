# OpenCode 配置说明（本仓库）

本仓库的 `opencode.json` **不写密钥**，只保留模型与 `enabled_providers` 等可共享项。当前默认模型为 **DeepSeek V4 Pro**，Zen 作为备用 Provider。API Key 放在环境变量里，启动 OpenCode 时无需再手动 `export`。

官方合并规则见 [Config - Locations / Precedence](https://open-code.ai/docs/en/config)。占位符语法见 [Config - Variables](https://open-code.ai/docs/en/config)。

---

## 1. 本仓库内文件

| 路径 | 作用 |
|------|------|
| `opencode.json` | 项目级：默认模型 `deepseek-v4-pro`、子模型 `deepseek-v4-flash`、启用思考模式。**不含** `apiKey`。 |
| `docs/examples/global-opencode.zen.file.json` | 复制到全局配置用：**密钥文件** + `{file:...}` 示例（Zen）。 |
| `docs/examples/global-opencode.zen.env.json` | 复制到全局配置用：**环境变量** + `{env:...}` 示例（Zen）。 |
| `../DEEPSEEK_V4_SETUP.md` | DeepSeek V4 完整配置指南（含 Claude Code）。 |

---

## 2. Provider 配置

### 2.1 当前 Provider：DeepSeek（默认）

通过 Fish 持久化变量设置：

```fish
set -Ux DEEPSEEK_API_KEY '你的_DeepSeek_API_Key'
```

全局配置 `~/.config/opencode/opencode.json` 通过占位符引用：

```json
{
  "deepseek": {
    "options": {
      "apiKey": "{env:DEEPSEEK_API_KEY}"
    }
  }
}
```

### 2.2 备用 Provider：Zen

```fish
set -Ux OPENCODE_ZEN_API_KEY '你的_Zen_API_Key'
```

---

## 3. 项目级配置 `opencode.json`

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

- `reasoning_effort: max`：最大思维链强度（DeepSeek V4 核心优势）
- `thinking: enabled`：显式开启思考模式
- 如需切换回 Zen：将 `enabled_providers` 改为 `["opencode"]`，`model` 改为 opencode 模型

---

## 4. 全局配置 `~/.config/opencode/opencode.json`

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

全局配置提供两个 Provider 的 API Key，项目配置决定使用哪个。

---

## 5. 模型与可选操作

启动后可执行：
- `/connect` — 连接/切换 Provider
- `/models` — 切换模型（DeepSeek V4 Pro / Flash 等）

DeepSeek V4 模型：
| 模型 | 说明 | 价格（输入） |
|------|------|-------------|
| `deepseek-v4-pro` | Pro 版，主模型 | $0.28/M |
| `deepseek-v4-flash` | Flash 版，轻量快速 | $0.14/M |

> `deepseek-chat` 和 `deepseek-reasoner` 将于 2026/07/24 废弃。

---

## 6. 安全

- 勿将含明文 `apiKey` 的 JSON 或填好的 `.env` 提交到远程仓库。
- DeepSeek 密钥若曾泄露，在 [DeepSeek Platform](https://platform.deepseek.com/api_keys) 作废并轮换。
- Zen 密钥若曾泄露，在 [OpenCode Zen 控制台](https://opencode.ai/auth) 作废并轮换。

---

## 7. 官方文档索引

- [Config](https://open-code.ai/docs/en/config)
- [Providers](https://open-code.ai/docs/en/providers)
- [DeepSeek + OpenCode 集成指南](https://api-docs.deepseek.com/guides/coding_agents#integrate-with-opencode)
- [DeepSeek 思考模式](https://api-docs.deepseek.com/guides/thinking_mode)
- [Zen](https://open-code.ai/docs/en/zen)
- [Schema](https://opencode.ai/config.json)
