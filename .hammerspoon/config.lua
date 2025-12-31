local M = {
    enabled = true,
    debug = true,
    lastScreen = nil,
    lastScreenChangeAt = 0,
    pollInterval = 0.2,
    minMouseMoveIntervalMs = 150,
    languageSourceIds = {
        en = "com.apple.keylayout.ABC",
        zh = "com.apple.inputmethod.SCIM.Shuangpin",
    },
    appInputLanguages = {
        ["TRAE"] = "zh",
        ["Antigravity"] = "zh",
        ["Zed"] = "zh",
        ["Visual Studio Code"] = "zh",
        ["Microsoft OneNote"] = "zh",
        ["Arc"] = "en",
        ["TradingView"] = "en"
    }
}
M.log = hs.logger.new("AutoFocus", "debug")
return M
