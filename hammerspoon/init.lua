hs.window.animationDuration = 0

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- Browser
hs.hotkey.bind({"cmd"}, "b", function()
    hs.application.launchOrFocus("Google Chrome")
end)

-- Terminal
hs.hotkey.bind({"cmd"}, "m", function()
    hs.application.launchOrFocus("iTerm")
end)

hs.hotkey.bind({"cmd"}, "return", function()
    hs.application.open("iTerm")
    local win = hs.window.focusedWindow()
    hs.eventtap.keyStroke({"cmd"}, "n")
end)

-- Slack
hs.hotkey.bind({"cmd"}, "s", function()
    hs.application.launchOrFocus("Slack")
end)

-- Outlook
hs.hotkey.bind({"cmd"}, "o", function()
    hs.application.launchOrFocus("Microsoft Outlook")
end)

hs.hotkey.bind({"cmd"}, "h", function()
    hs.application.launchOrFocus("Amazon Chime")
end)

hs.hotkey.bind({"cmd"}, "p", function()
    local win = hs.window.focusedWindow()
    if win ~= hs.window.desktop() then
        local desk = hs.window.desktop()
        desk:focus()
        desk:maximize()
    end
end)

-- local arrowHotkeys = {
--     h = hs.keycodes.map.left,
--     j = hs.keycodes.map.down,
--     l = hs.keycodes.map.right,
--     k = hs.keycodes.map.up
-- }
-- for key, arrow in pairs(arrowHotkeys) do
--   hs.hotkey.bind({ 'ctrl' }, key, function()
--     hs.eventtap.keyStroke(nil, arrow)
--  end)
-- end

-- Normal binds
local select_all = hs.hotkey.bind({"ctrl"}, "a", nil, function() hs.eventtap.keyStroke({"cmd"}, "a") end)
local copy = hs.hotkey.bind({"ctrl"}, "c", nil, function() hs.eventtap.keyStroke({"cmd"}, "c") end)
local paste = hs.hotkey.bind({"ctrl"}, "v", nil, function() hs.eventtap.keyStroke({"cmd"}, "v") end)
local undo = hs.hotkey.bind({"ctrl"}, "z", nil, function() hs.eventtap.keyStroke({"cmd"}, "z") end)
local find = hs.hotkey.bind({"ctrl"}, "f", nil, function() hs.eventtap.keyStroke({"cmd"}, "f") end)
local cut = hs.hotkey.bind({"ctrl"}, "x", nil, function() hs.eventtap.keyStroke({"cmd"}, "x") end)

local up = hs.hotkey.new({"ctrl"}, "k", nil, function() hs.eventtap.keyStroke({}, "up") end)
local down = hs.hotkey.new({"ctrl"}, "j", nil, function() hs.eventtap.keyStroke({}, "down") end)
local left = hs.hotkey.new({"ctrl"}, "h", nil, function() hs.eventtap.keyStroke({}, "left") end)
local right = hs.hotkey.new({"ctrl"}, "l", nil, function() hs.eventtap.keyStroke({}, "right") end)


-- Outlook
local OutlookCalInbox = hs.window.filter.new("Microsoft Outlook")

-- Outlook hotkeys
local calendarHotkey = hs.hotkey.new({ "cmd", "ctrl" }, "c", function()
    local calendarLoc = {}
    calendarLoc['y'] = 1060
    calendarLoc['x'] = 80
    hs.eventtap.leftClick(calendarLoc)
end)

local InboxHotkey = hs.hotkey.new({ "cmd", "ctrl" }, "m", function()
    local InboxLoc = {}
    InboxLoc['y'] = 1060
    InboxLoc['x'] = 30
    hs.eventtap.leftClick(InboxLoc)
end)

-- Subscribe to when your Google Chrome window is focused and unfocused
OutlookCalInbox
    :subscribe(hs.window.filter.windowFocused, function()
        calendarHotkey:enable()
        InboxHotkey:enable()
        up:enable()
        down:enable()
    end)
    :subscribe(hs.window.filter.windowUnfocused, function()
        calendarHotkey:disable()
        InboxHotkey:disable()
        up:disable()
        down:disable()
    end)

-- Slack
local slack_k = hs.hotkey.new({"ctrl"}, "k", nil, function() hs.eventtap.keyStroke({"cmd"}, "k") end)
local Slack_Hotkey = hs.window.filter.new("Slack")

Slack_Hotkey
    :subscribe(hs.window.filter.windowFocused, function()
        slack_k:enable()
        select_all:enable()
        copy:enable()
        paste:enable()
        undo:enable()
        cut:enable()
        find:enable()
    end)
    :subscribe(hs.window.filter.windowUnfocused, function()
        slack_k:disable()
        select_all:disable()
        copy:disable()
        paste:disable()
        cut:disable()
        undo:disable()
        find:disable()
    end)

-- Chrome
local Chrome_Hotkey = hs.window.filter.new("Google Chrome")
Chrome_Hotkey
    :subscribe(hs.window.filter.windowFocused, function()
        select_all:enable()
        copy:enable()
        paste:enable()
        undo:enable()
        find:enable()
        cut:enable()
        up:enable()
        down:enable()
    end)
    :subscribe(hs.window.filter.windowUnfocused, function()
        select_all:disable()
        copy:disable()
        paste:disable()
        undo:disable()
        find:disable()
        cut:disable()
        up:disable()
        down:disable()
    end)

-- iTerm
local Iterm_Hotkey = hs.window.filter.new("iTerm")
Iterm_Hotkey
    :subscribe(hs.window.filter.windowFocused, function()
        paste:enable()
    end)
    :subscribe(hs.window.filter.windowUnfocused, function()
        paste:disable()
    end)
