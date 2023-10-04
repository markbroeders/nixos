return {
	"akinsho/bufferline.nvim",
	opts = {
		options = {
			mode = 'buffers',
			offsets = {
				{filetype = 'NvimTree'}
			},
		},
		highlights = {
			buffer_selected = {
				italic = false
			},
			indicator_selected = {
				fg = {attribute = 'fg', highlight = 'Function'},
				italic = false
			}
		}
	},
}
