# QAA AirType + ADB Toolkit

面向 Windows + Android 的三个独立小工具：用手机给电脑输入文字，或用数字小键盘控制 Android 固定坐标点击。

## 快速下载

| 你的需求 | 下载 |
|---|---|
| 手机语音/手机输入法输入到电脑当前文本框 | `QAA-AirType-Official-Tray-v2.3.0.exe` |
| Android 真机无线调试 | `QAA-ADB-Tap-v1.1.0.exe` |
| 雷电模拟器、其他模拟器或 USB ADB 真机 | `QAA-ADB-Tap-v1.2.0-DirectADB.exe` |
| 一次下载全部三个程序 | `QAA-AirType-ADB-Toolkit-Windows.zip` |

- **主要下载入口：[GitHub Releases — v2026.07.24](https://github.com/sjlsl6/-/releases/tag/v2026.07.24)**
- **蓝奏云备用下载：[https://wwaug.lanzoub.com/iRb7j3y7gdmb](https://wwaug.lanzoub.com/iRb7j3y7gdmb)**

下载后请核对 [SHA-256](#sha-256-校验)。GitHub Releases 是本公开仓库的主要发布渠道；蓝奏云仅作为备用下载，不参与程序运行或发布流程。

> **项目身份说明**：本仓库是社区修改/扩展项目，不是 QAA-Tools 官方仓库。文件名中的 `Official` 是历史构建文件名，不代表本项目获得 QAA-Tools 官方背书或属于官方发行版。为保持已验证文件的哈希不变，该 EXE 不重命名。

## 三个组件

| 组件 | 版本 | 连接方式 | 适合场景 | 核心功能 |
|---|---:|---|---|---|
| QAA AirType | v2.3.0 | 手机浏览器 → 可信局域网 → Windows | 把手机当作电脑语音/文字输入设备 | 托盘常驻、二维码、Token 校验、向当前文本框输入 |
| QAA ADB Tap Wireless | v1.1.0 | Android 无线调试 | Android 真机无线使用 | 无线配对/连接、三套坐标、数字小键盘 `-` / `+`、ADB Shell 点击 |
| QAA ADB Tap DirectADB | v1.2.0 | 已存在的 ADB transport | 雷电模拟器、USB 调试真机 | 读取 `adb devices -l`、单设备直用、多设备选择、三套坐标与热键 |

三个程序彼此独立，可以只下载和运行需要的一个。

## AirType：手机语音/文字输入电脑

工作链路：`手机输入法/语音输入 → 手机网页 → 局域网 → Windows → 当前输入框`

1. 在 Windows 启动 AirType。
2. 从托盘打开二维码或手机访问地址。
3. 确保手机和电脑位于同一可信局域网，再用手机浏览器访问。
4. 先让电脑上的目标文本框获得焦点。
5. 在手机网页中使用手机输入法或语音转文字并发送。

程序使用运行时 Token 校验请求。请勿公开带 Token 的二维码、URL 或配置文件。

## Wireless ADB：无线真机

1. 在 Android 开发者选项中开启无线调试。
2. 启动 `QAA-ADB-Tap-v1.1.0.exe`，按界面完成无线配对/连接；也可手动填写连接地址。
3. 配置三套模式中的 `-` / `+` 点击坐标。
4. 使用数字小键盘 `-` 或 `+`，通过常驻 ADB Shell 触发 Android 点击。

无线配对码、ADB 地址和设备信息只应保留在本机。

## DirectADB：模拟器或 USB 真机

1. 先确保目标设备在 `adb devices -l` 中显示为 `device`。
2. 启动 `QAA-ADB-Tap-v1.2.0-DirectADB.exe`。
3. 只有一个可用设备时可直接使用；有多个设备时选择目标设备。
4. 配置三套坐标，使用数字小键盘 `-` / `+` 触发点击。

DirectADB 不要求填写无线 ADB IP/端口，不生成配对二维码，不执行 `adb connect`，也不依赖 mDNS。详细步骤见 [docs/USAGE.md](docs/USAGE.md)。

## SHA-256 校验

```text
fd685aba6db35ff8e4a24a5056fac2d7a0cfcf7faccaa89e9d2c5afe3ae871f7  QAA-ADB-Tap-v1.1.0.exe
933ac71e5d68b8a6e7d52968c298b758c2cb55bde93611234ce33ea392453cd2  QAA-ADB-Tap-v1.2.0-DirectADB.exe
0326275e8a0abed9d61b4ae713d9c0c84f2eb012632832f0bd72de82c2454cbc  QAA-AirType-Official-Tray-v2.3.0.exe
```

PowerShell 校验示例：

```powershell
Get-FileHash .\QAA-AirType-Official-Tray-v2.3.0.exe -Algorithm SHA256
```

Release 还提供可供批量校验的 `SHA256SUMS.txt`。

## 源码与构建

`src/` 中有三个独立的、可完整解压的源码 ZIP：

- `src/airtype-v2.3.0-source.zip`
- `src/adb-tap-wireless-v1.1.0-source.zip`
- `src/adb-tap-direct-v1.2.0-source.zip`

源码包不包含 EXE、运行时 `config.json`、个人 Token、真实设备序列号、ADB 配对信息或本机配置。三个项目均已使用 Go 1.23.2 通过 `go test ./...`，并完成 Windows amd64、`CGO_ENABLED=0`、GUI subsystem、`-trimpath` 构建验证。每个归档内都可直接运行：

```bat
build_windows.cmd
```

精确构建和可复现性说明见 [docs/BUILD.md](docs/BUILD.md)，架构说明见 [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)。

## 仓库结构

```text
docs/       使用、构建与架构文档
licenses/   第三方许可证文本
releases/   已发布二进制校验和与 Release 说明
src/        三套完整源码归档
```

## 隐私与安全

- AirType 主要用于可信局域网；不建议将服务端口直接暴露到公网。
- 不要公开带 Token 的访问地址、二维码、`config.json`、无线配对码、设备序列号或私人网络信息。
- ADB 权限较高，只应连接自己拥有或已经获得明确授权的设备。
- 本项目不包含广告 SDK、行为分析或遥测上报逻辑。

详见 [PRIVACY.md](PRIVACY.md) 与 [SECURITY.md](SECURITY.md)。

## 上游来源与许可证

AirType 参考/延续了 [QAA-Tools/qaa-airtype](https://github.com/QAA-Tools/qaa-airtype) 的使用目标。上游采用 MIT License，版权声明为 `Copyright (c) 2025 Sync Input Contributors`；本仓库保留该声明与 MIT 许可要求，并明确属于社区修改/扩展版本。

ADB 属于 Android/AOSP 相关组件。ADB Tap 可在用户主动操作时从 Genymobile 的 scrcpy Windows 发布包中提取 ADB 所需文件；这些第三方组件适用 Apache License 2.0。**本仓库与本次 Release 均不捆绑 ADB 或 scrcpy 二进制。**

本仓库原创/修改部分采用 MIT License。请同时阅读 [LICENSE](LICENSE)、[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) 和 [licenses/](licenses/)。

QAA、Google、Android、AOSP、Genymobile、scrcpy 等名称仅用于说明来源或兼容性，不代表任何官方背书。

## 免责声明

项目按“现状”提供，不作任何明示或默示保证。使用输入注入、ADB 或自动点击前，请自行确认目标设备、应用和使用场景符合相关授权、平台规则与法律要求。
