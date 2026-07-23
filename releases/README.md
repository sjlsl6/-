# Release files

普通用户优先从 GitHub Releases 下载可直接运行的 Windows EXE：

- GitHub Releases：https://github.com/sjlsl6/-/releases/latest
- 蓝奏云备用下载：https://wwaug.lanzoub.com/iRb7j3y7gdmb

正式发行版提供：

- `QAA-AirType-Official-Tray-v2.3.0.exe`
- `QAA-ADB-Tap-v1.1.0.exe`
- `QAA-ADB-Tap-v1.2.0-DirectADB.exe`
- `QAA-AirType-ADB-Toolkit-Windows.zip`（三个程序的一体包）
- `SHA256SUMS.txt`

GitHub 自动发布流程会从蓝奏云获取原始压缩包，并在创建 Release 前核验三个 EXE 的文件名和 SHA-256。只要有一个文件缺失或校验值不一致，发布流程就会失败。

> 注意：历史文件名 `QAA-AirType-Official-Tray-v2.3.0.exe` 中的 `Official` 仅是既有构建文件名，不代表本项目是 QAA-Tools 官方发行版。

这三个程序目前没有商业代码签名证书。Windows SmartScreen 可能显示“未知发布者”，请确认下载来源并按照 `SHA256SUMS.txt` 校验文件。
