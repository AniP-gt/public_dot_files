-- Yazi configuration

-- Setup zoxide integration
require("zoxide"):setup {
	update_db = true,  -- Update zoxide database when browsing
}

-- Setup git status display
require("git"):setup()
