# QAA Voice Input Toolkit｜豆包输入法 / 微信输入法语音输入 Windows

面向 Windows + Android 的三个独立小工具：把**豆包输入法、微信输入法或其他手机输入法的语音转文字结果发送到 Windows**，并可用数字小键盘控制 Android 真机或雷电模拟器固定坐标点击。

常用搜索关键词：`豆包输入法电脑语音输入`、`微信输入法电脑语音输入`、`手机语音输入电脑`、`雷电模拟器豆包输入法`、`无线 ADB 热键`、`Windows 语音转文字`。

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
5. 在手机网页中使用手机输入法或语音转文字，按手机键盘回车即可发送；需要在文字中换行时使用 `Shift+Enter` 或网页上的“插入换行”按钮。
6. Windows 收到文字后，会先粘贴到当前输入框，再自动模拟按下一次回车完成发送。

自动回车前程序会再次检查电脑焦点；如果焦点已经离开原来的目标窗口，文字可能已经粘贴，但程序不会继续自动按回车，以免误发到其他窗口。程序使用运行时 Token 校验请求。请勿公开带 Token 的二维码、URL 或配置文件。

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

## 雷电模拟器 + 豆包输入法

项目现有两条雷电 9 使用路线：

1. **普通切换路线**：雷电官方说明新版本不支持切换第三方输入法，其教程提供的雷电 9 旧版为 `9.0.44`；官方论坛也记录 `9.0.45`～`9.0.47` 的普通第三方输入法切换存在兼容问题。
2. **本项目作者实测路线**：雷电 `9.0.47` 开启 Root 后，通过 ADB 写入默认输入法，已成功使用豆包输入法。实测 Android 分辨率为 `1080 × 1920`、DPI `480`；小键盘 `-` 参考坐标为 `770,1195`，小键盘 `+` 参考坐标为 `965,1740`。

- [雷电官方：如何切换其他输入法](https://help.ldmnq.com/docs/ru-he-zai-mo-ni-qi-nei-qie-huan-shu-ru-fa)
- [雷电 9.0.44 官方安装包](https://res.ldmnq.com/download/leidian9/ldinst_9.0.44.exe)
- [雷电官方论坛：9.0.44 与后续版本的输入法兼容记录](https://www.ldmnq.com/forum/94588.html)
- [雷电官方：雷电 9 连接 ADB 教程](https://help.ldmnq.com/docs/LD9adbserver)
- [完整的雷电模拟器 + 豆包输入法配置教程](docs/LDPLAYER_DOUBAO.md)

> 雷电 9.0.44 和 9.0.47 都是旧版本。建议只将其作为语音输入/测试环境，不在模拟器内登录敏感账号，不安装来源不明的 APK。`770,1195` 与 `965,1740` 只适用于上述实测布局；请先使用程序的“测试减号/测试加号”功能确认点击位置。

## 组合用法：小键盘完成语音输入和发送

ADB Tap 的 `-` / `+` 本质上是两个**可配置的 Android 点击坐标**，并不是程序写死的固定按钮。配合 AirType 时，推荐这样设置：

- 数字小键盘 `-`：设置为手机或模拟器输入法的“点击说话/语音输入”按钮坐标。
- 数字小键盘 `+`：设置为手机或模拟器输入法的“回车”按钮坐标。

实际操作链路如下：

1. 在电脑上按数字小键盘 `-`，ADB Tap 点击手机/模拟器的语音输入按钮。
2. 说完文字后按数字小键盘 `+`，ADB Tap 点击手机输入法的回车按钮。
3. AirType 手机网页把这次回车识别为“发送”，将文字传到 Windows。
4. AirType 把文字粘贴到电脑当前获得焦点的输入框，并自动模拟一次 Windows 回车完成发送。

因此，在坐标配置正确且电脑焦点没有变化时，可以只用数字小键盘 `-` / `+` 完成“开始语音输入 → 手机发送 → 电脑粘贴并回车”的整套操作。Wireless 和 DirectADB 都支持这种配置；雷电模拟器通常选择 DirectADB。

豆包输入法和微信输入法都可以作为 AirType 的手机端输入法。ADB Tap 只负责点击坐标，不读取输入法内容；只要输入法能够在 AirType 网页输入文字并用回车发送，就可以使用这套组合方式。

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
