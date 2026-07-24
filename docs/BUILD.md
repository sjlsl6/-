# Build

## 已验证环境

- Go 1.23.2
- `GOOS=windows`
- `GOARCH=amd64`
- `CGO_ENABLED=0`
- Windows GUI subsystem
- `-trimpath`
- `-buildvcs=false`

三个源码 ZIP 解压后均包含 `go.mod`、完整源码、测试和 `build_windows.cmd`。进入对应根目录运行：

```bat
build_windows.cmd
```

脚本会先运行 `go test ./...`，测试成功后再生成 Windows GUI EXE。

| 源码包 | 输出 |
|---|---|
| `src/airtype-v2.3.0-source.zip` | `QAA-AirType-Official-Tray-v2.3.0.exe` |
| `src/adb-tap-wireless-v1.1.0-source.zip` | `QAA-ADB-Tap-v1.1.0.exe` |
| `src/adb-tap-direct-v1.2.0-source.zip` | `QAA-ADB-Tap-v1.2.0-DirectADB.exe` |

## 等效命令

Wireless 与 DirectADB：

```text
go test ./...
go build -buildvcs=false -trimpath -ldflags "-s -w -H=windowsgui" -o <输出文件名> .
```

AirType：

```text
go test ./...
go build -buildvcs=false -trimpath -ldflags "-H=windowsgui -s -w -buildid=N1kGQiO1P6MzOKbcXgXd/skKJPixqLtyG3qtgIffH/_rsAK9qPrzbXJoXR7YLR/TWbXoBLMtW9ip9oHsDoQ" -o QAA-AirType-Official-Tray-v2.3.0.exe .
```

## 可复现性验证

在固定源码、Go 1.23.2 和上述参数下：

- Wireless v1.1.0 重建结果与已测试 EXE 逐字节一致。
- DirectADB v1.2.0 重建结果与已测试 EXE 逐字节一致。
- AirType v2.3.0 的源码逻辑一致，但 Go 链接器生成的 Build ID 会影响文件哈希；归档中的构建脚本固定了原构建的 Build ID，因此重建结果也与已测试 EXE 逐字节一致。

这个 Build ID 只用于复现已经验证的历史二进制，不代表版本签名或安全凭据。更换 Go 版本、源码或链接参数后，不应继续声称新文件具有已发布 EXE 的哈希。

三个正式 EXE 的基准 SHA-256 见仓库根目录 README 和 `releases/SHA256SUMS.txt`。
