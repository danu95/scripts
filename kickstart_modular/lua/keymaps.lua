-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- vim: ts=2 sts=2 sw=2 et

-- FIX:  Die Mehrzahl meiner Änderungen & Ergänzungen, die von Kickstart nvim abweichen.
--
--
-- HACK: Press <leader>db to go to the dashboard
vim.keymap.set("n", "<leader>db", ":Dashboard<CR>", { noremap = true, silent = true })

-- HACK: Sicherstellen, dass das quickfix fenster nur 3 Zeilen hoch ist
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		-- Move the quickfix window to the very bottom
		-- vim.cmd("wincmd J")
		-- Set the height
		vim.cmd("resize 3")
	end,
})

-- HACK: neovim spell multiple languages
--
-- Keymap to switch spelling language to English lamw25wmal
-- To save the language settings configured on each buffer, you need to add
-- "localoptions" to vim.opt.sessionoptions in the `lua/config/options.lua` file
vim.keymap.set("n", "<leader>msle", function()
	vim.opt.spelllang = "en"
	vim.cmd("echo 'Spell language set to English'")
end, { desc = "Spelling language English" })

-- HACK: neovim spell multiple languages
--
-- Keymap to switch spelling language to german lamw25wmal
vim.keymap.set("n", "<leader>msld", function()
	vim.opt.spelllang = "de_ch"
	vim.cmd("echo 'Spell language set to German'")
end, { desc = "Spelling language German" })

-- HACK: neovim spell multiple languages
--
-- Keymap to switch spelling language to both german and english lamw25wmal
vim.keymap.set("n", "<leader>mslb", function()
	vim.opt.spelllang = "en,de_ch"
	vim.cmd("echo 'Spell language set to German and English'")
end, { desc = "Spelling language German and English" })

-- HACK: neovim spell multiple languages
--
-- Toggle spell checking for the current buffer
vim.keymap.set("n", "<leader>mo", function()
	vim.wo.spell = not vim.wo.spell -- flip the current state
	if vim.wo.spell then
		vim.cmd("echo 'Spell checking ON for this buffer.'")
	else
		vim.cmd("echo 'Spell checking OFF for this buffer.'")
	end
end, { desc = "Toggle spell checking for current buffer" })

-- HACK: neovim spell multiple languages
--
-- Show spelling suggestions / spell suggestions
-- NOTE: I changed this to accept the first spelling suggestion
vim.keymap.set("n", "<leader>mss", function()
	-- Simulate pressing "z=" with "m" option using feedkeys
	-- vim.api.nvim_replace_termcodes ensures "z=" is correctly interpreted
	-- 'm' is the {mode}, which in this case is 'Remap keys'. This is default.
	-- If {mode} is absent, keys are remapped.
	--
	-- I tried this keymap as usually with
	vim.cmd("normal! 1z=")
	-- But didn't work, only with Vim_feedkeys
	-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("z=", true, false, true), "m", true)
end, { desc = "[P]Spelling suggestions" })

-- HACK: neovim spell multiple languages
--
-- markdown good, accept spell suggestion
-- Add word under the cursor as a good word
-- vim.keymap.set('n', '<leader>msg', function()
--   vim.cmd 'normal! zg'
--   -- I do a write so that harper is updated
--   vim.cmd 'silent write'
-- end, { desc = '[P]Spelling add word to spellfile' })

-- HACK: neovim spell multiple languages
--
-- Undo zw, remove the word from the entry in 'spellfile'.
-- vim.keymap.set('n', '<leader>msu', function()
--   vim.cmd 'normal! zug'
-- end, { desc = '[P]Spelling undo, remove word from list' })

-- HACK: neovim spell multiple languages
--
-- Repeat the replacement done by |z=| for all matches with the replaced word
-- in the current window.
vim.keymap.set("n", "<leader>msr", function()
	-- vim.cmd(":spellr")
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":spellr\n", true, false, true), "m", true)
end, { desc = "[P]Spelling repeat" })
