local config = require("config")
hs.hotkey.bind({"cmd", "alt", "shift"}, "F", function()
    config.enabled = not config.enabled
    if config.enabled then
        hs.alert.show("Auto Focus: ON")
        config.log.i("Enabled")
    else
        hs.alert.show("Auto Focus: OFF")
        config.log.i("Disabled")
    end
end)
return {}
