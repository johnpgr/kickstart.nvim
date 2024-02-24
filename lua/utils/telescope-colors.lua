local catppuccin_colors = require("catppuccin.palettes").get_palette()
local gruber_colors = require("gruber-darker.palette")
local onedark_colors = require("utils.onedark-telescope")

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

for hl, col in pairs(telescope_colors_onedark) do
	vim.api.nvim_set_hl(0, hl, col)
end
