return {
	"L3MON4D3/LuaSnip",
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		-- load vscode style snippets from other plugins
        require("luasnip.loaders.from_vscode").lazy_load()
	end,
}
