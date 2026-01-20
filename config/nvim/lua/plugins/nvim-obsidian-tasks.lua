return {
	{
		"AniP-gt/nvim-obsidian-tasks.nvim",
		event = { "BufReadPost", "BufNewFile" },
		lazy = true,
		keys = {
			{ "<leader>x", mode = "n", desc = "Complete task (current line)" },
			{ "<leader>x", mode = "v", desc = "Complete tasks in selection" },
		},
		config = function()
			require("nvim-tasks").setup()
		end,
	},
}
