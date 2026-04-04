local function get_visual_selection()
    local _, ls, cs = unpack(vim.fn.getpos "'<")
    local _, le, ce = unpack(vim.fn.getpos "'>")
    local lines = vim.fn.getline(ls, le)
    if #lines == 0 then return "" end
    lines[#lines] = string.sub(lines[#lines], 1, ce)
    lines[1] = string.sub(lines[1], cs)
    return table.concat(lines, " ")
end
