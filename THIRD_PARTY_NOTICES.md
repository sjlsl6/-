# Third-party notices

本仓库包含或参考了第三方开源项目。各第三方组件仍受其原许可证约束。

## QAA AirType

- 上游项目：`QAA-Tools/qaa-airtype`
- 上游用途：通过手机端输入/语音输入，将文字发送到 Windows 电脑端输入位置。
- 上游许可证：MIT License
- 上游版权声明：`Copyright (c) 2025 Sync Input Contributors`

本仓库中的 AirType v2.3.0 是在相同使用目标基础上的 Windows/Go 实现与扩展版本，并非 QAA-Tools 官方发行版。根目录 `LICENSE` 保留了上游 MIT 版权与许可要求。

## Android Debug Bridge (ADB)

ADB 属于 Android Open Source Project。ADB 相关组件采用 Apache License 2.0。许可证全文见 `licenses/APACHE-2.0.txt`。

本仓库不直接提交 `adb.exe`、`AdbWinApi.dll` 或 `AdbWinUsbApi.dll`。

## scrcpy / Genymobile

DirectADB 与无线 ADB 版本包含“按用户操作准备 ADB”的逻辑，可从 Genymobile 发布的 scrcpy Windows 压缩包中提取 ADB 所需文件。scrcpy 使用 Apache License 2.0。

本仓库不捆绑 scrcpy 本体。相关第三方文件仍由其各自版权所有者授权。

## QR Code implementation notices

二维码实现相关第三方许可与历史来源声明见 `licenses/QR_CODE_LICENSE.txt`。

## Trademark / affiliation

`QAA`、`Android`、`scrcpy` 以及其他项目或产品名称仅用于说明兼容性与来源。本仓库不是 QAA-Tools、Google、Android Open Source Project 或 Genymobile 的官方项目，也未获得这些项目或组织的背书。
