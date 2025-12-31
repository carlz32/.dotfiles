local M = {}
function M.isPointInRect(pt, rect)
    if not pt or not rect then return false end
    return pt.x >= rect.x and pt.x <= (rect.x + rect.w) and pt.y >= rect.y and pt.y <= (rect.y + rect.h)
end
function M.isValidFrame(frame)
    return frame and type(frame.x) == "number" and type(frame.y) == "number" and type(frame.w) == "number" and type(frame.h) == "number" and frame.w > 1 and frame.h > 1
end
function M.currentScreen()
    local ok, scr = pcall(function() return hs.mouse.getCurrentScreen() end)
    if ok and scr then return scr end
    return hs.screen.mainScreen()
end
return M
