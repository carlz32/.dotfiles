-- 创建一个窗口过滤器
local wf = hs.window.filter.new()

-- 监听窗口聚焦事件
wf:subscribe(hs.window.filter.windowFocused, function(window)
    -- 获取当前聚焦窗口所在的屏幕
    local screen = window:screen()
    if not screen then return end

    -- 获取鼠标当前所在的屏幕
    local mouseScreen = hs.mouse.getCurrentScreen()

    -- 如果鼠标不在窗口所在的屏幕上，则移动鼠标
    if screen ~= mouseScreen then
        -- 获取窗口中心坐标
        local center = window:frame().center
        
        -- 将鼠标平滑移动到窗口中心
        hs.mouse.absolutePosition(center)
    end
end)

-- 提示配置文件已加载
hs.alert.show("Hammerspoon: 鼠标自动跟随已激活")