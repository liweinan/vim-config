return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- 配置 asm-lsp 用于汇编文件
        asm_lsp = {
          mason = false, -- 不通过 mason 安装，使用系统的 asm-lsp
          filetypes = { "asm", "s", "S" },
        },
        -- 配置 clangd 用于 C/C++ 文件
        clangd = {
          mason = true, -- 通过 mason 自动安装
        },
      },
    },
  },
}
