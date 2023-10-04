return {
	"epwalsh/obsidian.nvim",
	-- lazy = true,
	-- event = { "BufReadPre vim.fn.expand ~/Documenten/2023 Notitieboek/**.md" },
	-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
	-- event = { "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		dir = "~/Documents/2023 Notitieboek",  -- no need to call 'vim.fn.expand' here

		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = os.date("Journal/%Y/%m/"),
			-- Optional, if you want to change the date format for daily notes.
			date_format = "%Y-%m-%d"
		},

		-- Whether to add the output of the node_id_func to new notes in autocompletion.
		-- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
		prepend_note_id = false,

		-- Optional, set to true if you don't want obsidian.nvim to manage frontmatter.
		disable_frontmatter = true,
	},
}
