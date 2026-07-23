# Architecture

本仓库由三个相互独立、可单独构建运行的 Windows Go 项目组成。

## AirType

`手机浏览器/输入法 → 局域网 HTTP → Token 校验 → Windows 输入注入`

核心职责：局域网地址发现、网页服务、二维码、Token、本地托盘、文本发送与 Windows 输入。

## ADB Tap Wireless

`数字小键盘热键 → 常驻 ADB Shell → input tap X Y`

连接层支持无线调试二维码配对、mDNS/地址发现与手动连接。点击层维护三套坐标模式。

## ADB Tap DirectADB

`adb devices -l → 选择已在线设备 → 常驻 ADB Shell → input tap X Y`

DirectADB 将连接职责交给现有 ADB transport：程序不配对、不执行 `adb connect`，只使用已经在线的设备。

## Why keep both ADB variants?

无线版适合希望直接使用 Android 无线调试的真机；DirectADB 适合模拟器或已经通过 USB/其他方式进入 ADB 列表的设备。二者共享“热键 + 三套坐标 + 常驻 Shell”的交互思路，但连接模型不同，因此分别保留。
