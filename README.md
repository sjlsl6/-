# QAA AirType + ADB Toolkit

一个面向 Windows + Android 的本地输入辅助工具合集：用手机更方便地完成语音/文字输入，并可通过 ADB 把数字小键盘按键映射为 Android 屏幕点击。

本仓库同时保留三条稳定版本线：

| 组件 | 版本 | 主要用途 |
|---|---|---|
| QAA AirType | v2.3.0 | 手机网页输入/语音输入 → Windows 当前输入位置 |
| QAA ADB Tap Wireless | v1.1.0 | Android 无线调试配对/连接 + `-`/`+` 坐标点击 |
| QAA ADB Tap DirectADB | v1.2.0 | 直接使用 `adb devices` 中现有设备，适合雷电模拟器、USB 真机等 |

> **项目身份说明**：本仓库是社区修改/扩展项目，不是 `QAA-Tools` 官方发行版。历史二进制文件名中出现的 `Official` 不代表官方背书。

## 为什么做这个项目

电脑端语音输入在麦克风、识别效果和输入法体验上不一定理想，而手机端语音输入通常更顺手。AirType 让手机承担“输入设备”的角色：手机上完成语音转文字，再把文本发送到电脑当前输入框。

在此基础上，ADB Tap 解决另一类操作：当手机/模拟器上的固定按钮需要反复点击时，可以把数字小键盘 `-` / `+` 映射为 Android 的两个坐标点击，并准备三套可切换坐标模式。

## 三个组件的区别

### AirType v2.3.0

典型链路：

`手机输入法/语音输入 → 手机网页 → 局域网 → Windows AirType → 当前输入框`

主要能力：

- Windows 托盘常驻。
- 自动发现适合局域网访问的地址。
- 生成手机访问二维码。
- 使用随机 Token 对请求进行校验。
- 手机端发送文字后写入电脑当前输入位置。
- 适合搭配手机端语音输入法使用。

源码：`src/airtype-v2.3.0/`

### ADB Tap v1.1.0 — Wireless ADB

面向 Android 无线调试：

- 支持无线调试二维码配对流程。
- 支持手动 ADB 地址连接作为备用。
- 支持三套独立坐标模式。
- 数字小键盘 `-` / `+` 触发对应坐标点击。
- 使用常驻 ADB Shell，减少连续触发时反复启动 adb shell 的开销。

源码：`src/adb-tap-wireless-v1.1.0/`

### ADB Tap v1.2.0 — DirectADB

这是对连接层的定向改版：不再处理无线配对，而是直接复用已经存在的 ADB 设备连接。

- 不填 IP/端口。
- 不生成无线调试二维码。
- 不执行 `adb connect`。
- 不使用 mDNS 扫描。
- 读取 `adb devices -l`。
- 单个 `device` 状态设备时自动选择。
- 多设备时可选择目标设备。
- 适合雷电模拟器等模拟器，也支持已经授权的 USB 调试真机。
- 保留三套坐标模式、`-` / `+` 热键和常驻 Shell 点击链路。

源码：`src/adb-tap-direct-v1.2.0/`

## 推荐使用方式

只需要“手机语音输入到电脑”时，只运行 AirType 即可。

需要控制 Android 固定按钮时，再按设备连接方式选择一个 ADB Tap：

- 真机无线调试：Wireless v1.1.0。
- 雷电模拟器、USB 真机或已在 `adb devices` 中的设备：DirectADB v1.2.0。

详细步骤见 `docs/USAGE.md`。

## 源码目录

```text
src/
├─ airtype-v2.3.0/
├─ adb-tap-wireless-v1.1.0/
└─ adb-tap-direct-v1.2.0/

docs/
├─ USAGE.md
├─ BUILD.md
└─ ARCHITECTURE.md

licenses/
├─ APACHE-2.0.txt
└─ QR_CODE_LICENSE.txt
```

## 构建

三个项目均为 Go 项目，当前源码按 Go 1.23 系列验证。

在对应源码目录运行：

```bat
build_windows.cmd
```

脚本会先执行 `go test ./...`，然后构建 Windows amd64 GUI 程序。构建使用 `-trimpath`，减少本机绝对源码路径进入构建信息的风险。

完整说明见 `docs/BUILD.md`。

## 已验证二进制哈希

```text
fd685aba6db35ff8e4a24a5056fac2d7a0cfcf7faccaa89e9d2c5afe3ae871f7  QAA-ADB-Tap-v1.1.0.exe
933ac71e5d68b8a6e7d52968c298b758c2cb55bde93611234ce33ea392453cd2  QAA-ADB-Tap-v1.2.0-DirectADB.exe
0326275e8a0abed9d61b4ae713d9c0c84f2eb012632832f0bd72de82c2454cbc  QAA-AirType-Official-Tray-v2.3.0.exe
```

同样记录在 `releases/SHA256SUMS.txt`。

## 隐私与安全

- 不要把运行时 `config.json` 提交到公开仓库。
- 不要公开真实设备序列号、真实点击坐标、无线 ADB 配对码、个人 Token 或带 Token 的二维码/URL。
- AirType 设计用于可信局域网，不建议把服务端口直接暴露到公网。
- ADB 权限较高，只应连接你拥有或明确获授权控制的设备。

详见 `PRIVACY.md` 与 `SECURITY.md`。

## 上游来源与许可

本项目参考/延续了 `QAA-Tools/qaa-airtype` 的使用目标。上游项目采用 MIT License，原版权声明为：

`Copyright (c) 2025 Sync Input Contributors`

本仓库保留该版权与 MIT 许可要求，并对本仓库修改部分继续采用 MIT License。

ADB 属于 Android Open Source Project；DirectADB/无线版在用户主动准备 ADB 时可从 Genymobile 的 scrcpy Windows 发布包中提取 ADB 所需文件。相关组件遵循 Apache License 2.0。本仓库不直接提交 scrcpy 或 ADB 二进制。

二维码实现相关第三方声明见 `licenses/QR_CODE_LICENSE.txt`。

完整第三方说明见 `THIRD_PARTY_NOTICES.md`。

## License

本仓库原创/修改部分按 MIT License 开源；第三方代码与组件按其各自许可证授权。请同时阅读：

- `LICENSE`
- `THIRD_PARTY_NOTICES.md`
- `licenses/APACHE-2.0.txt`
- `licenses/QR_CODE_LICENSE.txt`

## Disclaimer

本项目按“现状”提供，不提供任何形式的担保。使用 ADB、自动点击或输入注入前，请自行确认目标设备、应用和使用场景符合相关授权、平台规则与法律要求。
