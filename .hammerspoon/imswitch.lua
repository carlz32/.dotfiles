local config = require("config")
local M = {}
local function setSourceID(sourceID)
    if not sourceID or sourceID == "" then return end
    local ok = hs.keycodes.currentSourceID(sourceID)
    if ok and config.debug then
        config.log.i("Input switched to sourceID " .. sourceID)
    elseif config.debug then
        config.log.i("Failed to switch sourceID: " .. sourceID)
    end
end
local function setInput(name)
    if not name or name == "" then return end
    local ok = hs.keycodes.setMethod(name)
    if not ok then ok = hs.keycodes.setLayout(name) end
    if ok and config.debug then
        config.log.i("Input switched to " .. name)
    elseif config.debug then
        config.log.i("Failed to switch input: " .. name)
    end
end
function M.switchByLanguage(lang)
    if not lang or lang == "" then return false end
    local ids = config.languageSourceIds or {}
    local target = ids[lang]
    if target then
        setSourceID(target)
        return true
    end
    return false
end
function M.en() return M.switchByLanguage("en") end
function M.zh() return M.switchByLanguage("zh") end
function M.ja() return M.switchByLanguage("ja") end
function M.applyForApp(appName)
    if not config.enabled then return end
    if not appName then return end
    local lang = config.appInputLanguages and config.appInputLanguages[appName]
    if type(lang) == "string" then
        if M.switchByLanguage(lang) then return end
    end
end
local wf = hs.window.filter.default
wf:subscribe(hs.window.filter.windowFocused, function(window, appName)
    M.applyForApp(appName)
end)
return M
