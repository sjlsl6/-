# Build

## Requirements

- Go 1.23 或兼容版本
- Windows amd64 目标
- 不需要 CGO

三个源码归档解压后均包含 `build_windows.cmd`。脚本会先执行测试，再以 `-trimpath` 和 Windows GUI 模式构建。

## AirType v2.3.0

解压 `src/airtype-v2.3.0-source.zip`，进入源码目录后运行：

```bat
build_windows.cmd
```

输出：`QAA-AirType-Official-Tray-v2.3.0.exe`

## Wireless ADB Tap v1.1.0

解压 `src/adb-tap-wireless-v1.1.0-source.zip`，进入源码目录后运行：

```bat
build_windows.cmd
```

输出：`QAA-ADB-Tap-v1.1.0.exe`

## DirectADB v1.2.0

解压 `src/adb-tap-direct-v1.2.0-source.zip`，进入源码目录后运行：

```bat
build_windows.cmd
```

输出：`QAA-ADB-Tap-v1.2.0-DirectADB.exe`

## Validation

本次公开发布前，三套源码均使用 Go 1.23.2 执行 `go test ./...` 并通过。

## Reproducibility notes

构建脚本使用 `-trimpath`，避免把本机源码绝对路径写入 Go 构建信息。二进制结果仍可能因 Go 版本、链接器和源码状态不同而产生不同哈希，因此发布时应重新生成对应 SHA-256。
