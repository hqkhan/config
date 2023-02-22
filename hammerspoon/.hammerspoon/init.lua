hs.window.animationDuration = 0
hyper       = {"cmd","alt","ctrl"}
shift_hyper = {"cmd","alt","ctrl","shift"}
ctrl_cmd    = {"cmd","ctrl"}

hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
Install=spoon.SpoonInstall

Install:andUse("WindowHalfsAndThirds",
               {
                 config = {
                   use_frame_correctness = true
                 },
                 hotkeys = 'default',
--                 loglevel = 'debug'
               }
)

Install:andUse("TextClipboardHistory",
               {
                 -- disable = true,
                 config = {
                   show_in_menubar = false,
                 },
                 hotkeys = {
                   toggle_clipboard = { { "cmd", "shift" }, "v" } },
                 start = true,
               }
)

Install:andUse("Caffeine", {
                 start = true,
                 hotkeys = {
                   toggle = { hyper, "1" }
                 },
--                 fn = BTT_caffeine_widget,
})

hs.loadSpoon("ReloadConfiguration")
-- spoon.ReloadConfiguration:start()
spoon.ReloadConfiguration:bindHotkeys({ reloadConfiguration = { {"cmd","ctrl"}, "r"} })

-- test
-- Browser
hs.hotkey.bind({"cmd"}, "b", function()
    hs.application.launchOrFocus("Firefox")
end)

-- Terminal
hs.hotkey.bind({"cmd"}, "m", function()
    hs.application.launchOrFocus("iTerm")
end)

hs.hotkey.bind({"cmd"}, "return", function()
    hs.application.launchOrFocus("iTerm")
    -- local win = hs.window.focusedWindow()
    -- hs.eventtap.keyStroke({"cmd"}, "n")
end)

-- Slack
hs.hotkey.bind({"cmd"}, "s", function()
    hs.application.launchOrFocus("Slack")
end)

-- Outlook
hs.hotkey.bind({"cmd"}, "o", function()
    hs.application.launchOrFocus("Microsoft Outlook")
end)

-- Snapshot
hs.hotkey.bind({"cmd", "ctrl"}, "m", function()
    hs.eventtap.keyStroke({"cmd", "shift"}, "4") 
end)

-- Chime
hs.hotkey.bind({"cmd"}, "h", function()
    hs.application.launchOrFocus("Amazon Chime")
end)

-- Dismiss outlook events
local DismissHotkey = hs.hotkey.bind({ "cmd", "ctrl" }, "d", function()
    local DismissLoc = {}
    DismissLoc['y'] = 1100
    DismissLoc['x'] = 1650
    hs.eventtap.leftClick(DismissLoc)
end)

-- Normal binds
local select_all = hs.hotkey.new({"ctrl"}, "a", nil, function() hs.eventtap.keyStroke({"cmd"}, "a") end)
local copy = hs.hotkey.new({"ctrl"}, "c", nil, function() hs.eventtap.keyStroke({"cmd"}, "c") end)
local paste = hs.hotkey.new({"ctrl"}, "v", nil, function() hs.eventtap.keyStroke({"cmd"}, "v") end)
local undo = hs.hotkey.new({"ctrl"}, "z", nil, function() hs.eventtap.keyStroke({"cmd"}, "z") end)
local find = hs.hotkey.new({"ctrl"}, "f", nil, function() hs.eventtap.keyStroke({"cmd"}, "f") end)
local cut = hs.hotkey.new({"ctrl"}, "x", nil, function() hs.eventtap.keyStroke({"cmd"}, "x") end)
local delete = hs.hotkey.new({"cmd"}, "delete", nil, function() hs.eventtap.keyStroke({"option"}, "delete") end)

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
        undo:enable()
        find:enable()
        delete:enable()
    end)
    :subscribe(hs.window.filter.windowUnfocused, function()
        slack_k:disable()
        delete:disable()
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
        delete:enable()
    end)
    :subscribe(hs.window.filter.windowUnfocused, function()
        select_all:disable()
        delete:disable()
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
        find:disable()
    end)
