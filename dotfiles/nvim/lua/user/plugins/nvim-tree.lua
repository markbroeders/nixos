return {
	"kyazdani42/nvim-tree.lua",
    opts = {
        hijack_cursor = true,
        view = {
            adaptive_size = true,
            width = 30,
            side = "left",
        },
    },
    keys = {
        { "<Leader>e", "<cmd>NvimTreeToggle<CR>", desc = "toggle file browser" },
        { "<Leader>nr", "<cmd>NvimTreeRefresh<CR>", desc = "refresh file browser" },
    },
}
