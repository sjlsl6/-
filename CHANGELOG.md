# Changelog

## Toolkit v2026.07.24

- 首次把 AirType v2.3.0、ADB Tap Wireless v1.1.0 与 DirectADB v1.2.0 作为同一 Toolkit 正式发布。
- 提供三个已验证独立 EXE、三合一 Windows ZIP 和 SHA-256 校验文件。
- 修复并替换三个损坏的源码 ZIP；加入完整测试、构建、许可证与来源说明。
- 清理此前基于 Issue、Actions 和第三方蓝奏解析服务的失败发布实验。
- GitHub Releases 作为主要下载入口，蓝奏云作为备用下载渠道。
- 补充 AirType 与 ADB Tap 的组合操作说明：小键盘 `-` 可配置为语音输入按钮，`+` 可配置为手机回车；AirType 接收文字后会粘贴并自动按 Windows 回车。

## AirType v2.3.0

- Windows 托盘常驻。
- 启动局域网手机输入网页。
- 生成手机访问二维码。
- 使用本地 Token 验证请求。
- 将手机端发送的文字写入电脑当前输入位置。

## ADB Tap v1.1.0 — Wireless ADB

- 支持 Android 无线调试。
- 支持二维码配对与手动 ADB 地址连接。
- 支持数字小键盘 `-` / `+` 触发 Android 坐标点击。
- 支持 3 套独立坐标模式。
- 使用常驻 ADB Shell 降低连续触发延迟。

## ADB Tap v1.2.0 — DirectADB

- 保留 v1.1.0 的热键、三模式坐标和常驻 Shell 点击链路。
- 移除无线配对、mDNS 扫描、`adb connect` 和 IP/端口输入。
- 直接读取 `adb devices -l`。
- 单设备自动选择，多设备可选择目标。
- 适用于雷电模拟器等已进入 ADB 设备列表的模拟器，也支持 USB 调试真机。
- “断开 QAA 点击通道”只关闭本程序常驻 Shell，不主动执行 `adb disconnect`。
