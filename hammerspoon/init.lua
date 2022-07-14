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

local arrowHotkeys = {
    h = hs.keycodes.map.left,
    j = hs.keycodes.map.down,
    l = hs.keycodes.map.right,
    k = hs.keycodes.map.up
}
for key, arrow in pairs(arrowHotkeys) do
  hs.hotkey.bind({ 'ctrl' }, key, function()
    hs.eventtap.keyStroke(nil, arrow)
 end)
end

hs.hotkey.bind({"cmd", "shift"}, "m", function()
    win = hs.window.focusedWindow()
    win:minimize()
end)
