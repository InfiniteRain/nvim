require("infiniterain.util").safe_require("lualine", "lualine.themes.nord", function(lualine, nord_theme)
	local colors = {
		blue = "#65D1FF",
		green = "#3EFFDC",
		violet = "#FF61EF",
		yellow = "#FFDA7B",
		black = "#000000",
	}

	nord_theme.normal.a.bg = colors.blue
	nord_theme.insert.a.bg = colors.green
	nord_theme.visual.a.bg = colors.violet
	nord_theme.command = {
		a = {
			gui = "bold",
			bg = colors.yellow,
			fg = colors.black,
		},
	}

	lualine.setup({
		options = {
			theme = nord_theme,
		},
	})
end)
