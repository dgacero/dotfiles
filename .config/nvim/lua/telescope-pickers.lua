-- This file is taken from:
-- https://github.com/nvim-telescope/telescope.nvim/issues/2014#issuecomment-1690573382

local telescopePickers = {}

local telescopeUtilities = require("telescope.utils")
local telescopeMakeEntryModule = require("telescope.make_entry")
local plenaryStrings = require("plenary.strings")
local devIcons = require("nvim-web-devicons")
local telescopeEntryDisplayModule = require("telescope.pickers.entry_display")

local fileTypeIconWidth = plenaryStrings.strdisplaywidth(devIcons.get_icon("fname", { default = true }))

function telescopePickers.getPathAndTail(fileName)
    local bufferNameTail = telescopeUtilities.path_tail(fileName)

    local pathWithoutTail = require("plenary.strings").truncate(fileName, #fileName - #bufferNameTail, "")

    local pathToDisplay = telescopeUtilities.transform_path({
        path_display = { "truncate" },
    }, pathWithoutTail)

    -- Deviation from the original snippet: truncation can drop the trailing
    -- slash, which would run the tail into the path with no separator.
    if pathToDisplay ~= "" and pathToDisplay:sub(-1) ~= "/" then
        pathToDisplay = pathToDisplay .. "/"
    end

    return bufferNameTail, pathToDisplay
end

-- Wraps a Find File picker to display entries with an icon and a truncated
-- path, since Telescope's default display doesn't look good.
-- Adapted from: https://github.com/nvim-telescope/telescope.nvim/issues/2014#issuecomment-1541423345
function telescopePickers.prettyFilesPicker(pickerAndOptions)
    if type(pickerAndOptions) ~= "table" or pickerAndOptions.picker == nil then
        print(
            "Incorrect argument format. Correct format is: { picker = 'desiredPicker', (optional) options = { ... } }"
        )
        return
    end

    options = pickerAndOptions.options or {}

    -- Reuse Telescope's entry maker as-is and only replace its `display`
    -- function, instead of rebuilding the whole entry table ourselves.
    local originalEntryMaker = telescopeMakeEntryModule.gen_from_file(options)

    options.entry_maker = function(line)
        local originalEntryTable = originalEntryMaker(line)

        local displayer = telescopeEntryDisplayModule.create({
            separator = " ",
            items = {
                { width = fileTypeIconWidth },
                { width = nil },
                { remaining = true },
            },
        })

        originalEntryTable.display = function(entry)
            local tail, pathToDisplay = telescopePickers.getPathAndTail(entry.value)

            -- Add a trailing space so the tail is separated from the path.
            local tailForDisplay = tail .. " "

            local icon, iconHighlight = telescopeUtilities.get_devicons(tail)

            return displayer({
                { icon, iconHighlight },
                tailForDisplay,
                { pathToDisplay, "TelescopeResultsComment" },
            })
        end

        return originalEntryTable
    end

    if pickerAndOptions.picker == "find_files" then
        require("telescope.builtin").find_files(options)
    elseif pickerAndOptions.picker == "git_files" then
        require("telescope.builtin").git_files(options)
    elseif pickerAndOptions.picker == "oldfiles" then
        require("telescope.builtin").oldfiles(options)
    elseif pickerAndOptions.picker == "" then
        print("Picker was not specified")
    else
        print("Picker is not supported by Pretty Find Files")
    end
end

-- Wraps a Grep Search picker to display entries with an icon and a truncated
-- path, since Telescope's default display doesn't look good.
function telescopePickers.prettyGrepPicker(pickerAndOptions)
    if type(pickerAndOptions) ~= "table" or pickerAndOptions.picker == nil then
        print(
            "Incorrect argument format. Correct format is: { picker = 'desiredPicker', (optional) options = { ... } }"
        )
        return
    end

    options = pickerAndOptions.options or {}

    -- Reuse Telescope's entry maker as-is and only replace its `display`
    -- function, instead of rebuilding the whole entry table ourselves.
    local originalEntryMaker = telescopeMakeEntryModule.gen_from_vimgrep(options)

    options.entry_maker = function(line)
        local originalEntryTable = originalEntryMaker(line)

        local displayer = telescopeEntryDisplayModule.create({
            separator = " ",
            items = {
                { width = fileTypeIconWidth },
                { width = nil },
                { width = nil },
                { remaining = true },
            },
        })

        originalEntryTable.display = function(entry)
            local tail, pathToDisplay = telescopePickers.getPathAndTail(entry.filename)

            local icon, iconHighlight = telescopeUtilities.get_devicons(tail)

            -- Add a trailing space so the tail is separated from the path.
            local tailForDisplay = tail .. " "

            -- Deviation from the original snippet: no "-> line:col" suffix.
            local text = options.file_encoding and vim.iconv(entry.text, options.file_encoding, "utf8") or entry.text

            return displayer({
                { icon, iconHighlight },
                tailForDisplay,
                { pathToDisplay, "TelescopeResultsComment" },
                text,
            })
        end

        return originalEntryTable
    end

    if pickerAndOptions.picker == "live_grep" then
        require("telescope.builtin").live_grep(options)
    elseif pickerAndOptions.picker == "grep_string" then
        require("telescope.builtin").grep_string(options)
    elseif pickerAndOptions.picker == "" then
        print("Picker was not specified")
    else
        print("Picker is not supported by Pretty Grep Picker")
    end
end

return telescopePickers
