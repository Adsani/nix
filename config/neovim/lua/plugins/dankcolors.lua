return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#1a1018',
				base01 = '#1a1018',
				base02 = '#a599a4',
				base03 = '#a599a4',
				base04 = '#ffeffd',
				base05 = '#fff8fe',
				base06 = '#fff8fe',
				base07 = '#fff8fe',
				base08 = '#ff9fa9',
				base09 = '#ff9fa9',
				base0A = '#ffb6f8',
				base0B = '#c1ffa5',
				base0C = '#ffd8fb',
				base0D = '#ffb6f8',
				base0E = '#ffc3f9',
				base0F = '#ffc3f9',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#a599a4',
				fg = '#fff8fe',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#ffb6f8',
				fg = '#1a1018',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#a599a4' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffd8fb', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#ffc3f9',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#ffb6f8',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#ffb6f8',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#ffd8fb',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#c1ffa5',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#ffeffd' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#ffeffd' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#a599a4',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
