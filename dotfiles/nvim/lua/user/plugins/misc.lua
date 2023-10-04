return {

	"nvim-lua/plenary.nvim",	-- Needed for telescope
	"tpope/vim-repeat",			-- Repeat actions

	-- Comments
	{ "numToStr/Comment.nvim", config = true },

	-- Icons
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},

	-- Fzf for telescope
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

	-- Markdown
	'godlygeek/tabular',
	'preservim/vim-markdown',
}
