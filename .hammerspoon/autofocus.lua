local config = require("config")
local utils = require("utils")
local imswitch = require("imswitch")
local heartbeat = 0
local function updateFocus()
    if not config.enabled then return end
    local currentScreen = utils.currentScreen()
    if not currentScreen then return end
    heartbeat = heartbeat + 1
    if config.debug and heartbeat % 20 == 0 then
        config.log.i(string.format("Heartbeat: Screen=%s", currentScreen:name()))
    end
    if config.lastScreen == currentScreen then return end
    config.lastScreen = currentScreen
    config.lastScreenChangeAt = hs.timer.secondsSinceEpoch() * 1000
    local windows = hs.window.orderedWindows()
    local frontWin = hs.window.frontmostWindow()
    for _, win in ipairs(windows) do
        if win:isVisible() and win:screen() == currentScreen then
            if not frontWin or win:id() ~= frontWin:id() then
                if config.debug then
                    config.log.i(string.format("Screen changed -> focusing '%s' on %s", win:title() or "NoTitle", currentScreen:name()))
                end
                win:focus()
                local app = win:application()
                local appName = app and app:name()
                imswitch.applyForApp(appName)
            end
            break
        end
    end
end
local M = {}
function M.start()
    config.mouseFocusTimer = hs.timer.doEvery(config.pollInterval, updateFocus)
end
return M
