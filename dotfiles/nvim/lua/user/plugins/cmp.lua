return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		-- completion sources
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function(args) require('luasnip').lsp_expand(args.body) end,
		},
		sources = cmp.config.sources({
			{ name = "luasnip" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "nvim_lua" },
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "buffer", keyword_length = 3 }, -- don't complete from buffer right away
		}),
		formatting = {
			-- Show where the completion opts are coming from
			-- format = ({
			-- 	with_text = true,
			-- 	menu = {
			-- 		luasnip = "[snippet]",
			-- 		nvim_lua = "[nvim]",
			-- 		nvim_lsp = "[LSP]",
			-- 		path = "[path]",
			-- 		buffer = "[buffer]",
			-- 		nvim_lsp_signature_help = "[param]",
			-- 	},
			-- }),
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = {
			['<Up>'] = cmp.mapping.select_prev_item(select_opts),
			['<Down>'] = cmp.mapping.select_next_item(select_opts),

			['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
			['<C-n>'] = cmp.mapping.select_next_item(select_opts),

			['<C-u>'] = cmp.mapping.scroll_docs(-4),
			['<C-d>'] = cmp.mapping.scroll_docs(4),

			['<C-e>'] = cmp.mapping.abort(),
			['<C-y>'] = cmp.mapping.confirm({select = true}),
			['<CR>'] = cmp.mapping.confirm({select = false}),

			['<C-f>'] = cmp.mapping(function(fallback)
				if luasnip.jumpable(1) then
					luasnip.jump(1)
				else
					fallback()
				end
			end, {'i', 's'}),

			['<C-b>'] = cmp.mapping(function(fallback)
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {'i', 's'}),

			['<Tab>'] = cmp.mapping(function(fallback)
				local col = vim.fn.col('.') - 1

				if cmp.visible() then
					cmp.select_next_item(select_opts)
				elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
					fallback()
				else
					cmp.complete()
				end
			end, {'i', 's'}),

			['<S-Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item(select_opts)
				else
					fallback()
				end
			end, {'i', 's'}),
		},
	})
end,
}
