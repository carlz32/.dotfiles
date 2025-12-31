local config = require("config")
local utils = require("utils")
local lastMoveAt = 0
local wf = hs.window.filter.default
wf:subscribe(hs.window.filter.windowFocused, function(window, appName)
    if not config.enabled then return end
    if not window then return end
    local nowMs = hs.timer.secondsSinceEpoch() * 1000
    if nowMs - lastMoveAt < config.minMouseMoveIntervalMs then return end
    local mousePos = hs.mouse.absolutePosition()
    local frame = window:frame()
    if not utils.isValidFrame(frame) then return end
    local winScreen = window:screen()
    local mouseScreen = utils.currentScreen()
    if not utils.isPointInRect(mousePos, frame) then
        local center = { x = frame.x + (frame.w / 2), y = frame.y + (frame.h / 2) }
        if winScreen ~= mouseScreen or (frame.w * frame.h) > 120000 then
            hs.mouse.absolutePosition(center)
            lastMoveAt = hs.timer.secondsSinceEpoch() * 1000
        end
    end
end)
return {}
