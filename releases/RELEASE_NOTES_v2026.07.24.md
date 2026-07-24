# QAA AirType + ADB Toolkit v2026.07.24

这是三个独立 Windows 工具的正式合集发布。

## 应该下载哪个文件

- 手机语音/手机输入法输入电脑：`QAA-AirType-Official-Tray-v2.3.0.exe`
- Android 真机无线调试：`QAA-ADB-Tap-v1.1.0.exe`
- 雷电模拟器或已经授权的 USB ADB 真机：`QAA-ADB-Tap-v1.2.0-DirectADB.exe`
- 全部下载：`QAA-AirType-ADB-Toolkit-Windows.zip`
- 校验下载：`SHA256SUMS.txt`

蓝奏云备用下载：[https://wwaug.lanzoub.com/iRb7j3y7gdmb](https://wwaug.lanzoub.com/iRb7j3y7gdmb)

GitHub Releases 是主要下载入口；蓝奏云仅为备用渠道，不是构建或发布依赖。

## 组件说明

### QAA AirType v2.3.0

手机浏览器/手机输入法/手机语音输入经可信局域网发送到 Windows 当前输入框。支持托盘常驻、二维码访问和 Token 校验。

文件名中的 `Official` 是历史构建文件名，不代表本项目获得 QAA-Tools 官方背书或属于官方发行版。

### QAA ADB Tap v1.1.0 Wireless

面向 Android 真机无线调试，支持无线 ADB 配对/连接、三套点击坐标和数字小键盘 `-` / `+` 热键。

### QAA ADB Tap v1.2.0 DirectADB

面向雷电模拟器、其他 ADB 模拟器和已经授权 USB 调试的 Android 真机。直接读取 `adb devices -l`；不填写无线 IP/端口、不配对、不生成二维码、不执行 `adb connect`、不依赖 mDNS。单设备可直接使用，多设备可选择目标。保留三套坐标与 `-` / `+` 热键。

## AirType + ADB Tap 组合操作

ADB Tap 的 `-` / `+` 是可配置点击坐标。配合 AirType 时，可以把数字小键盘 `-` 设置为点击手机/模拟器的语音输入按钮，把数字小键盘 `+` 设置为点击手机输入法的回车按钮。

按 `+` 后，AirType 手机网页会把回车识别为发送：文字传到 Windows 后，AirType 会将其粘贴到当前获得焦点的输入框，并自动模拟一次 Windows 回车。若电脑焦点中途发生变化，程序会停止自动回车，避免误发到其他窗口。

## 安全

- 请用 `SHA256SUMS.txt` 核对下载文件。
- AirType 主要用于可信局域网，不要将端口直接暴露到公网。
- ADB 权限较高，只能连接自己拥有或明确获授权的设备。
- 本 Release 不捆绑 ADB 或 scrcpy 二进制。

本项目是社区修改/扩展项目，不属于 QAA-Tools、Google、Android/AOSP、Genymobile 或 scrcpy 的官方发行，也未获得这些组织或项目的背书。
