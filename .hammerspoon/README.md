# Hammerspoon 脚本说明

本目录包含一组用于提升多屏与输入法体验的 Hammerspoon 脚本，支持自动聚焦窗口、跟随鼠标、按应用语言切换输入法，以及快捷开关与日志调试。

## 项目结构
- [init.lua](file:///Users/carlz/.dotfiles/.hammerspoon/init.lua) — 加载各模块并启动自动聚焦
- [config.lua](file:///Users/carlz/.dotfiles/.hammerspoon/config.lua) — 全局配置、语言到 Source ID 映射、应用到语言映射、日志器
- [autofocus.lua](file:///Users/carlz/.dotfiles/.hammerspoon/autofocus.lua) — 自动聚焦当前屏幕的可见窗口，并在聚焦后触发输入法切换
- [imswitch.lua](file:///Users/carlz/.dotfiles/.hammerspoon/imswitch.lua) — 输入法切换逻辑（基于语言与 `currentSourceID`），同时监听窗口焦点事件
- [mousefollow.lua](file:///Users/carlz/.dotfiles/.hammerspoon/mousefollow.lua) — 当窗口获得焦点时将鼠标移动到窗口中心（跨屏或大窗口时）
- [hotkeys.lua](file:///Users/carlz/.dotfiles/.hammerspoon/hotkeys.lua) — 全局快捷键开关
- [utils.lua](file:///Users/carlz/.dotfiles/.hammerspoon/utils.lua) — 通用工具函数
- [todo.md](file:///Users/carlz/.dotfiles/.hammerspoon/todo.md) — 需求草案

## 具备功能
- 自动聚焦：检测当前鼠标所在屏幕变化后，选取该屏幕顶部的可见窗口并聚焦
- 鼠标跟随：在窗口获得焦点时将鼠标移动到窗口中心，避免跨屏或大窗口下的鼠标偏离
- 输入法切换：按应用映射到的语言，使用 `hs.keycodes.currentSourceID` 切换到指定输入法或键盘布局
- 快捷开关：`Cmd + Alt + Shift + F` 切换全局启用状态（影响自动聚焦、鼠标跟随、输入法切换）
- 调试日志：在 `config.debug` 为 `true` 时输出详细日志，便于观察行为

## 配置说明
- 位置：[config.lua](file:///Users/carlz/.dotfiles/.hammerspoon/config.lua)
- 关键字段：
  - `enabled`：是否启用所有功能
  - `debug`：是否输出调试日志
  - `pollInterval`：自动聚焦轮询间隔
  - `minMouseMoveIntervalMs`：窗口焦点后鼠标移动的最小间隔
  - `languageSourceIds`：语言到输入源 Source ID 的映射（用于 `hs.keycodes.currentSourceID`）
  - `appInputLanguages`：应用名称到语言的映射（如 `"Arc" -> "en"`、`"Visual Studio Code" -> "zh"`）

示例：
```lua
languageSourceIds = {
  en = "com.apple.keylayout.ABC",
  zh = "com.apple.inputmethod.SCIM.Shuangpin"
},
appInputLanguages = {
  ["Arc"] = "en",
  ["Visual Studio Code"] = "zh"
}
```

## 使用与扩展
- 修改或添加应用语言映射：编辑 `appInputLanguages`，键为应用名称，值为语言代码（如 `en`、`zh`）
- 校正 Source ID：编辑 `languageSourceIds` 的值为系统实际的输入源 ID
  - 可在 Hammerspoon Console 查询：
    - `hs.keycodes.currentSourceID()`
    - `hs.keycodes.layouts()`
    - `hs.keycodes.methods()`

## 运行
- 将本目录放置到 `~/.hammerspoon` 或将本目录设为用户自定义配置路径
- 启动 Hammerspoon 或在菜单中手动 Reload 配置
- 状态提示：加载成功后会弹出提示“Hammerspoon Config Loaded”

## 模块交互
- 自动聚焦模块在聚焦窗口后调用输入法模块的语言切换函数：
  - 参考 [autofocus.lua](file:///Users/carlz/.dotfiles/.hammerspoon/autofocus.lua#L20-L24)
  - 输入法模块同时订阅焦点事件，覆盖手动切换窗口场景：参考 [imswitch.lua](file:///Users/carlz/.dotfiles/.hammerspoon/imswitch.lua)

