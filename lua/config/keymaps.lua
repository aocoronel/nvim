local map = function(map, lhs, rhs, opts) vim.keymap.set(map, lhs, rhs, opts) end -- Insert map
local imap = function(lhs, rhs, opts) vim.keymap.set("i", lhs, rhs, opts) end -- Insert map
local nmap = function(lhs, rhs, opts) vim.keymap.set("n", lhs, rhs, opts) end -- Normal map
local vmap = function(lhs, rhs, opts) vim.keymap.set("v", lhs, rhs, opts) end -- Visual map

local function map_keep_line(map, lhs, normal_cmd, opts)
    opts = opts or {}
    vim.keymap.set(map, lhs, function()
        local pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd("normal! " .. normal_cmd)
        vim.api.nvim_win_set_cursor(0, pos)
    end, opts)
end

-- Keep cursor position after action
local function imap_keep_line(lhs, normal_cmd, opts) map_keep_line("i", lhs, normal_cmd, opts) end
local function vmap_keep_line(lhs, normal_cmd, opts) map_keep_line("v", lhs, normal_cmd, opts) end
local function nmap_keep_line(lhs, normal_cmd, opts) map_keep_line("n", lhs, normal_cmd, opts) end

-- Emacs-like cancel
vim.api.nvim_set_keymap('c', '<C-g>', '<C-c>', { noremap = true, silent = true })

-- Open terminal in CWD
vim.keymap.set('n', '<leader>tt', function()
    local cwd = vim.fn.getcwd()
    os.execute("cd " .. cwd .. " && st &")
end, { desc = "Open st in current directory" })

function isearch_selected()
    vim.cmd 'normal! "ly'
    vim.api.nvim_feedkeys("/", "n", false)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-r>"<CR>', true, false, true), "n", false)
end

vmap("<leader>/", function() isearch_selected() end, {
    desc = "Search yanked text forward",
})

nmap("<leader><tab>s", ":source %<CR>", { desc = "Source lua file" })

-- How to quit nvim?

nmap("<leader>qq", "<CMD>qa<CR>", { desc = "Quit All" })
nmap("<leader>qQ", "<CMD>qa!<CR>", { desc = "Quit All (No Save)" })

-- Emacs-like insert mode keybindings

--- Motions

map({ "n", "i", "v" }, "<C-b>", "<Left>", { noremap = true }) -- backward char
map({ "n", "i", "v" }, "<C-p>", "<Up>", { noremap = true }) -- previous line
map({ "n", "i", "v" }, "<C-n>", "<Down>", { noremap = true }) -- next line
map({ "n", "i", "v" }, "<C-f>", "<Right>", { noremap = true }) -- forward char

map({ "n", "i", "v" }, "<C-a>", "<Home>", { noremap = true }) -- beginning of line
map({ "n", "i", "v" }, "<C-e>", "<End>", { noremap = true }) -- end of line

map({ "n", "i", "v" }, "C-v", "<C-o><C-d>", { silent = true }) -- Move half page down
map({ "n", "i", "v" }, "M-v", "<C-o><C-u>", { silent = true }) -- Move half page up

imap("<M-f>", "<C-o>w", { noremap = true }) -- forward word
imap("<M-b>", "<C-o>b", { noremap = true }) -- backward word
imap("<M-a>", "<C-o>(", { noremap = true }) -- move to start of sentence
imap("<M-e>", "<C-o>)", { noremap = true }) -- move to end of sentence
imap("<M-lt>", "<C-o>gg", { noremap = true }) -- move to start of buffer M-<
imap("<M->>", "<C-o>G", { noremap = true }) -- move to end of buffer M->

imap("<C-/>", "<C-o>u", { noremap = true }) -- undo
imap("<C-\\>", "<C-o>R", { noremap = true }) -- redo

imap("<C-s>", "<C-o>/", { noremap = true }) -- search
vmap("<C-x>s", 'y/<C-r>"<CR>', { noremap = true }) -- search selection

imap("<M-x>", "<C-o>:", { noremap = true }) -- IDO?

imap("<C-d>", "<Del>", { noremap = true }) -- Delete next char
imap("<C-k>", "<C-o>d$", { noremap = true }) -- kill to end of line
imap("<C-M-k>", "<C-o>dd", { noremap = true }) -- kill line

imap("<C-t>", "<Esc>xpi", { noremap = true }) -- transpose chars
imap("<M-t>", "<Esc>daWWPi", { noremap = true }) -- transpose words

imap("<M-d>", "<Esc>dwi", { noremap = true }) -- kill word forward
imap("<M-BS>", "<Esc>dbi", { noremap = true }) -- kill word backward

imap("<M-u>", "<Esc>gUiwi", { noremap = true }) -- upcase word
imap("<M-l>", "<Esc>guiwi", { noremap = true }) -- downcase word
imap("<M-c>", "<Esc>gUiw~i", { noremap = true }) -- capitalize word

imap("<C-_>", "<C-o>u", { noremap = true }) -- undo
imap("<C-\\>", "<C-o><C-r>", { noremap = true }) -- redo

-- Visual

imap("<C-Space>", "<Esc>v", { noremap = true, silent = true }) -- Insert to Visual Mode
vmap("<C-Space>", "<Esc>i", { noremap = true, silent = true }) -- Visual to Insert Mode

vmap("<C-w>", "c<Esc>i", { noremap = true }) -- kill
vmap("<C-y>", "p<Esc>i", { noremap = true }) -- yank
vmap("<M-w>", "y<Esc>i", { noremap = true }) -- copy

-- Move current line up
imap("<M-p>", function()
    vim.cmd "m .-2"
    vim.cmd "normal! =="
end, { silent = true })

-- Move current line down
imap("<M-n>", function()
    vim.cmd "m .+1"
    vim.cmd "normal! =="
end, { silent = true })

-- Duplicate line
imap_keep_line("<M-,>", "yyP", { silent = true })

nmap("<C-d>", "<C-d>zz", { desc = "Page Down and Center" }) -- Better Page Move: Page Down and Center
nmap("<C-u>", "<C-u>zz", { desc = "Page Up and Center" }) -- Better Page Move: Page Up and Center

nmap("<M-h>", ":cnext<CR>", { desc = "Next QuickFix" })
nmap("<M-l>", ":cprev<CR>", { desc = "Previous QuickFix" })

nmap("<leader>cx", ":!chmod +x %<CR>", { desc = "Make Executable" })

nmap("<leader>fmd", vim.lsp.buf.format, { desc = "[L]SP Format" })

nmap("<leader>ts", ":set spell!<CR>", { noremap = true, silent = true, desc = "Toggle: [S]pell" })

nmap("N", "Nzzzv", { desc = "Previous and center" })
nmap("n", "nzzzv", { desc = "Next and center" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
nmap("n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
nmap("N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

vmap("<leader>sS", ":!sort<CR>", { desc = "Sort" })

nmap("<leader>ss", ":%s/", { desc = "Search & Replace" })
vmap("<leader>ss", ":s/", { desc = "Search & Replace" })

vmap("J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move line down" })
vmap("K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move line up" })

nmap("<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
nmap("<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
nmap("<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
nmap("<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

nmap("<C-Up>", "<CMD>resize +2<CR>", { desc = "Increase Window Height" })
nmap("<C-Down>", "<CMD>resize -2<CR>", { desc = "Decrease Window Height" })
nmap("<C-Left>", "<CMD>vertical resize -2<CR>", { desc = "Decrease Window Width" })
nmap("<C-Right>", "<CMD>vertical resize +2<CR>", { desc = "Increase Window Width" })

nmap("<A-Tab>", "<CMD>:b#<CR>", { desc = "Last buffer" })
nmap("<S-h>", "<CMD>bprevious<CR>", { desc = "Prev Buffer" })
nmap("<S-l>", "<CMD>bnext<CR>", { desc = "Next Buffer" })
nmap("<leader>bD", "<CMD>:bd<CR>", { desc = "Delete Buffer and Window" })
nmap("<leader>bb", "<CMD>e #<CR>", { desc = "Switch to Other Buffer" })
nmap("[b", "<CMD>bprevious<CR>", { desc = "Prev Buffer" })
nmap("]b", "<CMD>bnext<CR>", { desc = "Next Buffer" })

nmap("<leader>O", ":%bdelete|edit#<CR>", { desc = "Kill all buffer, but current" })
nmap("<leader>o", "<CMD>only<CR>", { desc = "Kill all panes, but current" })

nmap(
    "<leader>ur",
    "<CMD>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / Clear hlsearch / Diff Update" }
)

nmap("<leader>K", "<CMD>norm! K<CR>", { desc = "manpage" })

vmap("<", "<gv", { desc = "Indenting keeps position" })
vmap(">", ">gv", { desc = "Indenting keeps position" })

nmap("gco", "o<esc>Vcx<esc><CMD>normal gcc<CR>fxa<bs>", { desc = "Add Comment Below" })
nmap("gcO", "O<esc>Vcx<esc><CMD>normal gcc<CR>fxa<bs>", { desc = "Add Comment Above" })

nmap("<leader>fn", "<CMD>enew<CR>", { desc = "New File" })

nmap("<leader>xl", function()
    local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
    if not success and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = "Location List" })

nmap("<leader>xq", function()
    local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
    if not success and err then vim.notify(err, vim.log.levels.ERROR) end
end, { desc = "Quickfix List" })

nmap("[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
nmap("]q", vim.cmd.cnext, { desc = "Next Quickfix" })

local diagnostic_goto = function(next, severity)
    return function()
        vim.diagnostic.jump {
            count = (next and 1 or -1) * vim.v.count1,
            severity = severity and vim.diagnostic.severity[severity] or nil,
            float = true,
        }
    end
end
nmap("<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
nmap("]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
nmap("[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
nmap("]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
nmap("[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
nmap("]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
nmap("[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- highlights under cursor
nmap("<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
nmap("<leader>uI", function()
    vim.treesitter.inspect_tree()
    vim.api.nvim_input "I"
end, { desc = "Inspect Tree" })

-- tabs
nmap("<leader><tab>l", "<CMD>tablast<CR>", { desc = "Last Tab" })
nmap("<leader><tab>o", "<CMD>tabonly<CR>", { desc = "Close Other Tabs" })
nmap("<leader><tab>f", "<CMD>tabfirst<CR>", { desc = "First Tab" })
nmap("<leader><tab>n", "<CMD>tabnew<CR>", { desc = "New Tab" })
nmap("<leader><tab>]", "<CMD>tabnext<CR>", { desc = "Next Tab" })
nmap("<leader><tab>d", "<CMD>tabclose<CR>", { desc = "Close Tab" })
nmap("<leader><tab>[", "<CMD>tabprevious<CR>", { desc = "Previous Tab" })

vim.api.nvim_create_user_command("Duck", function()
    local query = vim.fn.input "DuckDuckGo search: "
    if query == "" then return end

    local url = "https://duckduckgo.com/?q=" .. vim.fn.escape(query, " ")
    vim.fn.jobstart({ "xdg-open", url }, { detach = true })
end, {})

nmap("<leader>gx", ":!setsid xdg-open <c-r><c-a>", { desc = "Follow URL" })
nmap("<leader>gX", ":Duck<CR>", { desc = "Search in DuckDuckGo" })

---- Plugins ----

nmap("<leader>Dj", "<CMD>Oil<CR>", { desc = "Oil" })
nmap("<leader>Dh", "<CMD>Oil ~/<CR>", { desc = "Oil: Home" })
nmap("<leader>Cc", "<CMD>Compile<CR>", { desc = "Compile" })

vim.keymap.set("n", "<leader>Dg", function()
    local oil = require "oil"
    local telescope = require "telescope.builtin"
    local cwd = oil.get_current_dir()
    telescope.live_grep { cwd = cwd }
end, { desc = "Grep in Oil folder" })

-- Telescope

nmap(
    "<leader>fd",
    function()
        require("telescope.builtin").find_files {
            cwd = "~/dev",
            find_command = {
                "rg",
                "--files",
                "--hidden",
                "--glob",
                "!.git*",
                "--glob",
                "!*.{avif,jpg,jpeg,png,webp,webm,mp4,mkv}",
            },
        }
    end,
    { desc = "Find ~/dev files" }
)
nmap("<leader>fc", "<CMD>Telescope find_files cwd=~/.config/nvim<CR>", { desc = "Find Nvim Configs" })
nmap("<leader>fs", "<CMD>Telescope lsp_document_symbols<CR>", { desc = "Find Definitions" })

nmap(
    "<leader>sZ",
    ":lua require('telescope.builtin').lsp_definitions({ reuse_win = true })<CR>",
    { desc = "Goto Definition" },
    { has = "definition" }
)
nmap("<leader>,", "<CMD>Telescope buffers sort_mru=true sort_lastused=true<CR>", { desc = "Switch Buffer" })
nmap("<leader>:", "<CMD>Telescope command_history<CR>", { desc = "Command History" })

nmap(
    "<leader>/",
    function() require("telescope.builtin").current_buffer_fuzzy_find(require "telescope.themes") end,
    { desc = "[/] Fuzzily search in current buffer" }
)

nmap("gr", "<CMD>Telescope lsp_references<CR>", { desc = "References", nowait = true })
nmap(
    "gI",
    function() require("telescope.builtin").lsp_implementations { reuse_win = true } end,
    { desc = "Goto Implementation" }
)
nmap(
    "gy",
    function() require("telescope.builtin").lsp_type_definitions { reuse_win = true } end,
    { desc = "Goto T[y]pe Definition" }
)

nmap(
    "<leader>fb",
    "<CMD>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<CR>",
    { desc = "Buffers" }
)
nmap("<leader>fB", "<CMD>Telescope buffers<CR>", { desc = "Buffers (all)" })
nmap("<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "Find Files" })
nmap("<leader>fk", "<CMD>Telescope keymaps<CR>", { desc = "Find Keymaps" })
nmap("<leader>fh", "<CMD>Telescope help_tags<CR>", { desc = "Find Help" })
nmap("<leader>fl", "<CMD>Telescope man_pages<CR>", { desc = "Find Man Pages" })

nmap("<leader>sf", "<CMD>Telescope find_files<CR>", { desc = "[S]earch [F]iles" })
nmap("<leader>sz", "<CMD>Telescope builtin<CR>", { desc = "[S]earch [S]elect Telescope" })
nmap("<leader>sw", "<CMD>Telescope grep_string<CR>", { desc = "[S]earch current [W]ord" })
nmap("<leader>sg", "<CMD>Telescope live_grep<CR>", { desc = "[S]earch by [G]rep" })
nmap("<leader>sd", "<CMD>Telescope diagnostics<CR>", { desc = "[S]earch [D]iagnostics" })
nmap("<leader>sr", "<CMD>Telescope resume<CR>", { desc = "[S]earch [R]esume" })
nmap("<leader><leader>", "<CMD>Telescope buffers<CR>", { desc = "[ ] Find existing buffers" })
nmap("<leader>s.", "<CMD>Telescope oldfiles<CR>", { desc = '[S]earch Recent Files ("." for repeat)' })

nmap("<leader>fg", "<CMD>Telescope git_files<CR>", { desc = "Find Files (git-files)" })
nmap("<leader>gc", "<CMD>Telescope git_commits<CR>", { desc = "Commits" })
nmap("<leader>gl", "<CMD>Telescope git_commits<CR>", { desc = "Commits" })
nmap("<leader>gS", "<CMD>Telescope git_status<CR>", { desc = "Status" })
nmap("<leader>gZ", "<CMD>Telescope git_stash<CR>", { desc = "Git Stash" })

nmap('<leader>s"', "<CMD>Telescope registers<CR>", { desc = "Registers" })
nmap("<leader>sy", "<CMD>Telescope search_history<CR>", { desc = "Search History" })
nmap("<leader>sa", "<CMD>Telescope autocommands<CR>", { desc = "Auto Commands" })
nmap("<leader>sb", "<CMD>Telescope current_buffer_fuzzy_find<CR>", { desc = "Buffer Lines" })
nmap("<leader>sc", "<CMD>Telescope command_history<CR>", { desc = "Command History" })
nmap("<leader>sC", "<CMD>Telescope commands<CR>", { desc = "Commands" })
nmap("<leader>sD", "<CMD>Telescope diagnostics bufnr=0<CR>", { desc = "[S]earch Buffer [D]iagnostics" })
nmap("<leader>sh", "<CMD>Telescope help_tags<CR>", { desc = "Help Pages" })
nmap("<leader>sH", "<CMD>Telescope highlights<CR>", { desc = "Search Highlight Groups" })
nmap("<leader>sj", "<CMD>Telescope jumplist<CR>", { desc = "Jumplist" })
nmap("<leader>sk", "<CMD>Telescope keymaps<CR>", { desc = "Key Maps" })
nmap("<leader>sl", "<CMD>Telescope loclist<CR>", { desc = "Location List" })
nmap("<leader>sM", "<CMD>Telescope man_pages<CR>", { desc = "Man Pages" })
nmap("<leader>sm", "<CMD>Telescope marks<CR>", { desc = "Jump to Mark" })
nmap("<leader>so", "<CMD>Telescope vim_options<CR>", { desc = "Options" })
nmap("<leader>sR", "<CMD>Telescope resume<CR>", { desc = "Resume" })
nmap("<leader>sq", "<CMD>Telescope quickfix<CR>", { desc = "Quickfix List" })

nmap(
    "<leader>s/",
    function()
        require("telescope.builtin").live_grep {
            grep_open_files = true,
            prompt_title = "Live Grep in Open Files",
        }
    end,
    { desc = "[S]earch [/] in Open Files" }
)

-- lazy.nvim

nmap("<leader>l", "<CMD>Lazy<CR>", { desc = "Lazy" })

-- Visual Selections

local function get_visual_selection()
    local _, ls, cs = unpack(vim.fn.getpos "'<")
    local _, le, ce = unpack(vim.fn.getpos "'>")
    local lines = vim.fn.getline(ls, le)
    if #lines == 0 then return "" end
    lines[#lines] = string.sub(lines[#lines], 1, ce)
    lines[1] = string.sub(lines[1], cs)
    return table.concat(lines, " ")
end

vmap("<leader>sg", function()
    local text = get_visual_selection()
    require("telescope.builtin").grep_string { search = text }
end, { desc = "Grep visual selection" })

vmap("<leader>sf", function()
    local text = get_visual_selection()
    require("telescope.builtin").find_files { default_text = text }
end, { desc = "Find files from selection" })

vmap("<leader>k", function()
    local text = get_visual_selection()
    vim.cmd("Man " .. text)
end, { desc = "Man page from selection" })

vmap("<leader>se", function()
    local text = get_visual_selection()
    vim.cmd("Oil " .. text)
end)

vmap("ga", ":EasyAlign<CR>") -- save file
nmap("ga", "<CMD>EasyAlign<CR>", { desc = "Quit All" })
