# Source archives

本目录提供三套完整源码归档，均不包含 EXE、运行时 `config.json`、个人 Token、真实设备序列号、ADB 配对信息或本机配置。

| 文件 | 内容 | SHA-256 |
|---|---|---|
| `airtype-v2.3.0-source.zip` | QAA AirType v2.3.0 | `f47f00d2b0514d4cc1ba02ccdd64a253f8d2e6abaa882768f200d435135f6a6e` |
| `adb-tap-wireless-v1.1.0-source.zip` | QAA ADB Tap v1.1.0 Wireless | `107cc45b8841eaa5c78030cb3bc53981527ab003c7ccb4daf683c35011803640` |
| `adb-tap-direct-v1.2.0-source.zip` | QAA ADB Tap v1.2.0 DirectADB | `5d2fabd1c0380bca8e55937497e7dac6673a61351d52114aa308436674b5c89c` |

三份归档均已完成：

- ZIP central directory 与压缩数据完整性测试；
- 全量解压测试；
- `go.mod`、源码和测试文件检查；
- EXE、运行时配置与敏感信息排除检查；
- Go 1.23.2 `go test ./...`；
- Windows amd64 GUI 重建并与已测试 EXE 逐字节比较。

构建说明见 `../docs/BUILD.md`。
