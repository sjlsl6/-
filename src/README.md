# Source archives

本目录提供三套纯源码归档，均不包含 EXE、运行时 `config.json` 或私人设备配置。

| 文件 | 内容 |
|---|---|
| `airtype-v2.3.0-source.zip` | QAA AirType v2.3.0 源码 |
| `adb-tap-wireless-v1.1.0-source.zip` | 无线 ADB Tap v1.1.0 源码 |
| `adb-tap-direct-v1.2.0-source.zip` | DirectADB v1.2.0 源码 |

源码归档 SHA-256：

```text
2f3364905995e281295adf1f5ff534e02fd6d47969ae6832c7a7725d282f0128  airtype-v2.3.0-source.zip
e17d5575276f7d890ca5c736eb3d0ac640714fcc3feaa7af7696c78b63bbf43d  adb-tap-wireless-v1.1.0-source.zip
eda8f9c53f32781fca6f089f88a1ad9356fb07a1dada6384328bfe67fabd5b59  adb-tap-direct-v1.2.0-source.zip
```

三份归档均已完成 ZIP 完整性检查、`go test ./...` 测试和 Windows 重建验证。下载后解压对应归档即可查看、修改和构建源码。构建说明见 `../docs/BUILD.md`。
