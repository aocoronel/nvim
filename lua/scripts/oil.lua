local function get_visual_selection()
    local _, ls, cs = unpack(vim.fn.getpos "'<")
    local _, le, ce = unpack(vim.fn.getpos "'>")
    local lines = vim.fn.getline(ls, le)
    if #lines == 0 then return "" end
    lines[#lines] = string.sub(lines[#lines], 1, ce)
    lines[1] = string.sub(lines[1], cs)
    return table.concat(lines, " ")
end

local oil_find_file = function()
    local oil = require "oil"
    local telescope = require "telescope.builtin"
    local Path = require "plenary.path"

    local cwd = oil.get_current_dir()

    telescope.find_files {
        cwd = cwd,
        attach_mappings = function(prompt_bufnr, map)
            local actions = require "telescope.actions"
            local action_state = require "telescope.actions.state"

            map("i", "<CR>", function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                local path_str = selection.path or selection.filename or selection[1]
                if not path_str then
                    vim.notify("Could not get path for selection!", vim.log.levels.ERROR)
                    return
                end

                local selected_path = Path:new(path_str)
                local target_dir

                if selected_path:is_dir() then
                    target_dir = selected_path:absolute()
                else
                    target_dir = selected_path:parent():absolute()
                end

                oil.open(target_dir, { cursor = selected_path:make_relative(target_dir) })
            end)

            return true
        end,
    }
end

local oil_find_dir = function()
    local oil = require "oil"
    local telescope = require "telescope.builtin"
    local Path = require "plenary.path"

    local cwd = oil.get_current_dir()

    telescope.find_files {
        find_command = { "fd", "--type", "d" }, -- requires fd installed
        cwd = cwd,
        attach_mappings = function(prompt_bufnr, map)
            local actions = require "telescope.actions"
            local action_state = require "telescope.actions.state"

            map("i", "<CR>", function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                local path_str = selection.path or selection.filename or selection[1]
                if not path_str then
                    vim.notify("Could not get path for selection!", vim.log.levels.ERROR)
                    return
                end

                local selected_path = Path:new(path_str)
                local target_dir

                if selected_path:is_dir() then
                    target_dir = selected_path:absolute()
                else
                    target_dir = selected_path:parent():absolute()
                end

                oil.open(target_dir, { cursor = selected_path:make_relative(target_dir) })
            end)

            return true
        end,
    }
end

local oil_open_image_viewer = function()
    local oil = require "oil"
    local cwd = oil.get_current_dir()

    vim.fn.jobstart({ "nsxiv", "-t", cwd }, { detach = true })
end

local oil_symlink = function()
    local oil = require "oil"
    local actions = require "oil.actions"

    if vim.bo.filetype ~= "oil" then
        vim.notify("Not in Oil", vim.log.levels.ERROR)
        return
    end

    local entry = oil.get_cursor_entry()
    if not entry then
        vim.notify("Could not find entry under cursor", vim.log.levels.ERROR)
        return
    end

    local entry_title = entry.name
    if entry.type == "directory" then entry_title = entry_title .. "/" end
    local cwd = oil.get_current_dir()
    local source = cwd .. entry_title

    local link_path = vim.fn.input("Symlink path: ", cwd)
    if link_path == "" then return end

    vim.fn.jobstart({ "ln", "-s", source, link_path }, { detach = true })

    actions.refresh.callback()
end

local oil_external = function()
    local oil = require "oil"

    if vim.bo.filetype ~= "oil" then
        vim.notify("Not in Oil", vim.log.levels.ERROR)
        return
    end

    local entry = oil.get_cursor_entry()
    if not entry then
        vim.notify("Could not find entry under cursor", vim.log.levels.ERROR)
        return
    end

    local entry_title = entry.name
    if entry.type == "directory" then entry_title = entry_title .. "/" end
    local cwd = oil.get_current_dir()
    local source = cwd .. entry_title

    vim.notify("Opening: " .. source, vim.log.levels.WARN)

    local linkhandler = vim.fn.expand "~/.local/bin/linkhandler"
    vim.fn.jobstart({ linkhandler, source, "true" }, { detach = true })
end

local oil_change_dir = function()
  local oil = require("oil")
  local cwd = oil.get_current_dir()

  vim.uv.chdir(cwd)
end

vim.keymap.set("n", "<leader>Dd", function() oil_find_dir() end, { desc = "Oil: find dir and jump" })
vim.keymap.set("n", "<leader>Df", function() oil_find_file() end, { desc = "Oil: find file and jump" })
vim.keymap.set("n", "<leader>Di", function() oil_open_image_viewer() end, { desc = "Oil: open Nsxiv in cwd" })
vim.keymap.set("n", "<leader>DS", function() oil_symlink() end, { desc = "Oil: Create symlink from selected file" })
vim.keymap.set("n", "<leader>Dx", function() oil_external() end, { desc = "Oil: Open file with external app" })
vim.keymap.set("n", "<leader><tab>c", function() oil_change_dir() end, { desc = "Oil: Sync dir" })
