return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    -- 配置文件名显示为完整路径
    opts.sections.lualine_c = {
      {
        "filename",
        path = 3, -- 0 = 只显示文件名, 1 = 相对路径, 2 = 绝对路径, 3 = 绝对路径（home 目录用 ~ 替代）
        shorting_target = 0, -- 设置为 0 禁用路径缩短
      },
    }
    return opts
  end,
}
