return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	ft = { "markdown" },
	keys = {
		{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Markdown Preview" },
	},
	config = function()
		-- basic plugin settings
		vim.g.mkdp_theme = "dark"

		-- Repo-specific CSS support: if the specified repo CSS exists, combine it with
		-- the plugin's default markdown.css and point mkdp_markdown_css to the combined file.
		-- This preserves the default GitHub style while applying repo overrides.

		local uv = vim.loop

		local function file_exists(path)
			return path and uv.fs_stat(path) ~= nil
		end

		local function read_file(path)
			local f = io.open(path, "r")
			if not f then
				return nil
			end
			local s = f:read("*a")
			f:close()
			return s
		end

		local function write_file(path, content)
			local f = io.open(path, "w")
			if not f then
				return false
			end
			f:write(content)
			f:close()
			return true
		end

		local function find_default_markdown_css()
			local data = vim.fn.stdpath("data")
			local candidates = {
				data .. "/lazy/markdown-preview.nvim/app/_static/markdown.css",
				data .. "/site/pack/packer/start/markdown-preview.nvim/app/_static/markdown.css",
				data .. "/pack/packer/start/markdown-preview.nvim/app/_static/markdown.css",
			}
			for _, p in ipairs(candidates) do
				if file_exists(p) then
					return p
				end
			end
			return nil
		end

		local function build_combined_css(repo_css_path)
			if not file_exists(repo_css_path) then
				return nil
			end
			local cache_dir = vim.fn.stdpath("cache")
			local out_path = cache_dir .. "/mkdp_repo_combined.css"

			local out_stat = uv.fs_stat(out_path)
			local repo_stat = uv.fs_stat(repo_css_path)
			local default_path = find_default_markdown_css()
			local default_stat = default_path and uv.fs_stat(default_path) or nil

			local function _mtime(stat)
				if not stat or not stat.mtime then
					return 0
				end
				local m = stat.mtime
				if type(m) == "table" then
					-- luv/luv2 represents mtime as a table like {sec=..., nsec=...} or {tv_sec=..., tv_nsec=...}
					local sec = m.sec or m.tv_sec or 0
					local nsec = m.nsec or m.tv_nsec or 0
					return sec + (nsec / 1e9)
				elseif type(m) == "number" then
					return m
				else
					return 0
				end
			end

			local out_mtime = _mtime(out_stat)
			local repo_mtime = _mtime(repo_stat)
			local default_mtime = _mtime(default_stat)

			-- If cached file is newer than sources, reuse it
			if
				out_stat
				and repo_stat
				and out_mtime >= repo_mtime
				and (not default_stat or out_mtime >= default_mtime)
			then
				return out_path
			end

			local parts = {}
			if default_path then
				local d = read_file(default_path)
				if d then
					table.insert(parts, "/* default markdown.css */\n" .. d)
				end
			end
			local r = read_file(repo_css_path)
			if r then
				table.insert(parts, "/* repo style: " .. repo_css_path .. " */\n" .. r)
			end

			if write_file(out_path, table.concat(parts, "\n\n")) then
				return out_path
			end
			return nil
		end

		local function apply_repo_style_for_aniki()
			if vim.bo.filetype ~= "markdown" then
				return
			end

			-- Explicit repo path provided by the user
			local repo_style = ""

			if file_exists(repo_style) then
				local combined = build_combined_css(repo_style)
				if combined and file_exists(combined) then
					vim.g.mkdp_markdown_css = combined
					return
				end
			end

			-- Fallback: use plugin default
			vim.g.mkdp_markdown_css = nil
		end

		-- Apply when opening markdown files
		vim.api.nvim_create_autocmd({ "BufReadPost", "BufEnter", "BufNewFile" }, {
			pattern = { "*.md", "*.markdown" },
			callback = apply_repo_style_for_aniki,
		})
	end,
}
