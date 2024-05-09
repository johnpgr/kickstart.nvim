local catppuccin_colors = require("catppuccin.palettes").get_palette()
local gruber_colors = require("gruber-darker.palette")
local onedark_colors = require("utils.colors.onedark")
local iceberg_colors = require("utils.colors.iceberg")
local rosepine_colors = require("rose-pine.palette")
local tokyonight_colors = require("tokyonight.colors").default

local telescope_colors_tokyonight = {
	TelescopeMatching = { fg = iceberg_colors.function_fg },
	TelescopeSelection = { fg = iceberg_colors.text_fg, bg = tokyonight_colors.bg_highlight },
	TelescopeResultsTitle = { bg = tokyonight_colors.purple, fg = tokyonight_colors.bg },
	TelescopeResultsNormal = { bg = tokyonight_colors.bg },
	TelescopeResultsBorder = { bg = tokyonight_colors.bg, fg = tokyonight_colors.bg },
	TelescopePreviewTitle = { bg = tokyonight_colors.orange, fg = tokyonight_colors.bg },
	TelescopePreviewNormal = { bg = tokyonight_colors.bg_dark },
	TelescopePreviewBorder = { bg = tokyonight_colors.bg_dark, fg = tokyonight_colors.bg_dark },
	TelescopePromptPrefix = { bg = tokyonight_colors.bg_dark },
	TelescopePromptNormal = { bg = tokyonight_colors.bg_dark },
	TelescopePromptBorder = { bg = tokyonight_colors.bg_dark, fg = tokyonight_colors.bg_dark },
	TelescopePromptTitle = { bg = tokyonight_colors.teal, fg = tokyonight_colors.bg },
}

local telescope_colors_iceberg = {
	TelescopeMatching = { fg = iceberg_colors.function_fg },
	TelescopeSelection = { fg = iceberg_colors.text_fg, bg = iceberg_colors.cursorcolor_bg },
	TelescopeResultsTitle = { fg = iceberg_colors.normal_bg },
	TelescopeResultsNormal = { bg = iceberg_colors.normal_bg },
	TelescopeResultsBorder = { bg = iceberg_colors.normal_bg, fg = iceberg_colors.normal_bg },
	TelescopePreviewTitle = { bg = iceberg_colors.function_fg, fg = iceberg_colors.normal_bg },
	TelescopePreviewNormal = { bg = iceberg_colors.cursorcolor_bg },
	TelescopePreviewBorder = { bg = iceberg_colors.cursorcolor_bg, fg = iceberg_colors.cursorcolor_bg },
	TelescopePromptPrefix = { bg = iceberg_colors.overlay_bg },
	TelescopePromptNormal = { bg = iceberg_colors.overlay_bg },
	TelescopePromptBorder = { bg = iceberg_colors.overlay_bg, fg = iceberg_colors.overlay_bg },
	TelescopePromptTitle = { bg = iceberg_colors.string_fg, fg = iceberg_colors.normal_bg },
}

local telescope_colors_rosepine = {
	TelescopeMatching = { fg = rosepine_colors.love },
	TelescopeSelection = { fg = rosepine_colors.text, bg = rosepine_colors.overlay },
	TelescopeResultsTitle = { fg = rosepine_colors.base },
	TelescopeResultsNormal = { bg = rosepine_colors.base },
	TelescopeResultsBorder = { bg = rosepine_colors.base, fg = rosepine_colors.base },
	TelescopePreviewTitle = { bg = rosepine_colors.iris, fg = rosepine_colors.base },
	TelescopePreviewNormal = { bg = rosepine_colors.highlight_low },
	TelescopePreviewBorder = { bg = rosepine_colors.highlight_low, fg = rosepine_colors.highlight_low },
	TelescopePromptPrefix = { bg = rosepine_colors._nc },
	TelescopePromptNormal = { bg = rosepine_colors._nc },
	TelescopePromptBorder = { bg = rosepine_colors._nc, fg = rosepine_colors._nc },
	TelescopePromptTitle = { bg = rosepine_colors.rose, fg = catppuccin_colors.base },
}

local telescope_colors_catppuccin = {
	TelescopeMatching = { fg = catppuccin_colors.flamingo },
	TelescopeSelection = { fg = catppuccin_colors.text, bg = catppuccin_colors.surface0, bold = true },
	TelescopePromptPrefix = { bg = catppuccin_colors.surface0 },
	TelescopePromptNormal = { bg = catppuccin_colors.surface0 },
	TelescopeResultsNormal = { bg = catppuccin_colors.mantle },
	TelescopePreviewNormal = { bg = catppuccin_colors.mantle },
	TelescopePromptBorder = { bg = catppuccin_colors.surface0, fg = catppuccin_colors.surface0 },
	TelescopeResultsBorder = { bg = catppuccin_colors.mantle, fg = catppuccin_colors.mantle },
	TelescopePreviewBorder = { bg = catppuccin_colors.mantle, fg = catppuccin_colors.mantle },
	TelescopePromptTitle = { bg = catppuccin_colors.pink, fg = catppuccin_colors.mantle },
	TelescopeResultsTitle = { fg = catppuccin_colors.mantle },
	TelescopePreviewTitle = { bg = catppuccin_colors.green, fg = catppuccin_colors.mantle },
}

local telescope_colors_gruber = {
	TelescopeMatching = { fg = gruber_colors.yellow:to_string() },
	TelescopeSelection = { fg = gruber_colors.fg:to_string(), bg = gruber_colors['bg+2']:to_string() },
	TelescopePromptPrefix = { bg = gruber_colors.bg:to_string() },
	TelescopePromptNormal = { bg = gruber_colors.bg:to_string() },
	TelescopeResultsNormal = { bg = gruber_colors['bg+1']:to_string() },
	TelescopePreviewNormal = { bg = gruber_colors['bg+1']:to_string() },
	TelescopePromptBorder = { bg = gruber_colors.bg:to_string(), fg = gruber_colors.bg:to_string() },
	TelescopeResultsBorder = { bg = gruber_colors['bg+1']:to_string(), fg = gruber_colors['bg+1']:to_string() },
	TelescopePreviewBorder = { bg = gruber_colors['bg+1']:to_string(), fg = gruber_colors['bg+1']:to_string() },
	TelescopePromptTitle = { bg = gruber_colors.yellow:to_string(), fg = gruber_colors['bg+1']:to_string() },
	TelescopeResultsTitle = { fg = gruber_colors['bg+1']:to_string() },
	TelescopePreviewTitle = { bg = gruber_colors.green:to_string(), fg = gruber_colors['bg+1']:to_string() }
}

local telescope_colors_onedark = {
	TelescopePromptBorder = {
		fg = onedark_colors.black2,
		bg = onedark_colors.black2,
	},
	TelescopePromptNormal = {
		fg = onedark_colors.white,
		bg = onedark_colors.black2,
	},
	TelescopePromptPrefix = {
		fg = onedark_colors.red,
		bg = onedark_colors.black2,
	},
	TelescopePreviewTitle = {
		fg = onedark_colors.black,
		bg = onedark_colors.green,
	},
	TelescopePromptTitle = {
		fg = onedark_colors.black,
		bg = onedark_colors.red,
	},
	TelescopeResultsTitle = {
		fg = onedark_colors.black,
		bg = onedark_colors.dark_purple,
	},
	TelescopeResultsBorder = {
		fg = onedark_colors.one_bg,
		bg = onedark_colors.one_bg,
	},
	TelescopePreviewBorder = {
		fg = onedark_colors.one_bg,
		bg = onedark_colors.one_bg,
	},
	TelescopeSelection = {
		bg = onedark_colors.line,
		fg = onedark_colors.white
	},
	TelescopeResultsDiffAdd = {
		fg = onedark_colors.green,
	},
	TelescopeResultsDiffChange = {
		fg = onedark_colors.yellow,
	},
	TelescopeResultsDiffDelete = {
		fg = onedark_colors.red,
	},
}


for hl, col in pairs(telescope_colors_tokyonight) do
	vim.api.nvim_set_hl(0, hl, col)
end
