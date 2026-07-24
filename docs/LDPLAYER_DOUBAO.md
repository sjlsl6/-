# 雷电模拟器 + 豆包输入法语音输入教程

本教程用于在 Windows 上组合使用：

- 雷电模拟器 9.0.44，或已经实测成功的 Root 版 9.0.47；
- 豆包输入法 Android 版；
- `QAA-ADB-Tap-v1.2.0-DirectADB.exe`；
- `QAA-AirType-Official-Tray-v2.3.0.exe`。

最终操作链路：

`小键盘 - → 点击豆包输入法“点击说话” → 语音转文字 → 小键盘 + → 点击输入法回车 → AirType 发送到 Windows → Windows 自动回车`

## 1. 两条可用路线

雷电官方的第三方输入法教程明确注明“新版本模拟器不支持切换输入法”，并提供旧版安装包。其雷电 9 下载目标为 `9.0.44`。雷电官方论坛也记录：`9.0.45`、`9.0.46`、`9.0.47` 无法使用搜狗、QQ、百度、讯飞等第三方输入法，而 `9.0.44` 可以使用。

- [雷电官方：模拟器如何切换其他输入法](https://help.ldmnq.com/docs/ru-he-zai-mo-ni-qi-nei-qie-huan-shu-ru-fa)
- [雷电 9.0.44 官方安装包](https://res.ldmnq.com/download/leidian9/ldinst_9.0.44.exe)
- [雷电官方论坛：第三方输入法版本兼容记录](https://www.ldmnq.com/forum/94588.html)

因此有两种选择：

- 不想使用 Root/命令行：使用雷电 9.0.44，按 Android 设置页面正常启用第三方输入法。
- 使用本文原作者的实测配置：雷电 9.0.47 开启 Root，通过 ADB 强制设置豆包输入法。这个办法已经实际验证成功，但不是雷电 9.0.47 的普通设置页切换。

豆包输入法当前 Android 版需要较新的 Android 系统；雷电 9 使用 Android 9，适合这套配置。雷电 5 虽然也有官方旧版输入法方案，但不作为本教程的豆包输入法推荐环境。

9.0.44 和 9.0.47 都属于旧版本。建议只把模拟器作为语音输入或测试环境，不在其中登录敏感账号，不安装来源不明的 APK。

## 2. 安装并切换豆包输入法

### 雷电 9.0.44：普通切换

1. 安装雷电模拟器 9.0.44。
2. 从可信来源取得豆包输入法 Android APK，并安装到模拟器。
3. 打开雷电的 Android 系统设置。
4. 依次进入“系统 → 语言和输入法 → 虚拟键盘 → 管理键盘”。
5. 启用豆包输入法。
6. 打开任意输入框，通过输入法切换按钮选择豆包输入法。

如果安装成功但无法在“管理键盘”中启用或无法切换，先核对雷电版本。

### 雷电 9.0.47：Root 实测切换

先在雷电设置中开启 Root。豆包输入法组件为：

```text
com.bytedance.android.doubaoime/.ImeService
```

普通 `ime set` 可能短暂显示 selected，随后又被系统输入法切回。本项目作者的实测环境使用下面的命令写入默认输入法：

```bat
adb shell su -c "settings put secure default_input_method com.bytedance.android.doubaoime/.ImeService"
```

检查默认输入法：

```bat
adb shell settings get secure default_input_method
```

检查当前实际运行的输入法：

```bat
adb shell dumpsys input_method | findstr /i "mCurMethodId mSelectedMethodId"
```

成功时应看到 `com.bytedance.android.doubaoime/.ImeService`。

## 3. 让 DirectADB 识别雷电模拟器

1. 启动雷电模拟器。
2. 运行 `QAA-ADB-Tap-v1.2.0-DirectADB.exe`。
3. 点击检测/刷新设备。
4. 只有一个 `device` 状态设备时直接使用；多开模拟器或同时连接手机时，选择正确设备。

也可以在雷电安装目录打开命令提示符并执行：

```bat
adb devices
```

雷电官方说明，单开实例通常从 `emulator-5554` 开始，多开实例可能依次为 `emulator-5556`、`emulator-5558` 等。以 `adb devices` 的实际结果为准。

[雷电官方：雷电 9 连接 ADB 教程](https://help.ldmnq.com/docs/LD9adbserver)

## 4. 设置减号与加号坐标

ADB Tap 中的坐标是 **Android 屏幕坐标**，不是 Windows 桌面坐标：

- 数字小键盘 `-`：豆包输入法“点击说话/语音输入”按钮中心；
- 数字小键盘 `+`：豆包输入法“回车/发送”按钮中心。

推荐测量方法：

1. 固定雷电模拟器的 Android 分辨率、DPI 和屏幕方向。
2. 在 Android 开发者选项中临时开启“指针位置”，点击目标按钮并读取顶部显示的 X/Y。
3. 将坐标填入 DirectADB 当前模式。
4. 分别点击“测试当前模式减号”和“测试当前模式加号”。
5. 两个测试都准确后再保存；测试完成后可以关闭“指针位置”。

坐标会随分辨率、DPI、屏幕方向、豆包输入法版本和键盘高度变化。即使参考别人的数值，也必须先测试，避免误点。

### 原作者实测条件与坐标

- 雷电模拟器：`9.0.47`；
- Root：已开启；
- 机型/分辨率预设：手机版；
- Android 分辨率：`1080 × 1920`；
- DPI：`480`；
- CPU：4 核（推荐）；
- 内存：4096M（推荐）；
- 磁盘管理：空间不够时自动扩充；
- 磁盘共享：`System.vmdk` 可写入；
- Android 内核：Android 9；
- 输入法：豆包输入法；
- 连接工具：DirectADB v1.2.0；
- 小键盘 `-`：豆包输入法“点击说话”，`X=770, Y=1195`；
- 小键盘 `+`：豆包输入法“换行/回车”，`X=965, Y=1740`。

DirectADB 中可参考填写：

```text
减号（-）：770,1195
加号（+）：965,1740
```

也可以直接用 ADB 验证：

```bat
adb shell input tap 770 1195
adb shell input tap 965 1740
```

第一条应点击“点击说话”，第二条应点击右下角“换行/回车”。这些坐标只对应上述 `1080 × 1920 / DPI 480` 布局；输入法升级或键盘高度变化后仍可能需要重新测量。

## 5. 配合 AirType 自动发送到 Windows

1. Windows 启动 AirType。
2. 在雷电模拟器浏览器中打开 AirType 手机网页。
3. 让 Windows 目标文本框保持焦点。
4. 按数字小键盘 `-`，开始豆包语音输入。
5. 说完后按数字小键盘 `+`，点击豆包输入法回车。
6. AirType 网页将回车识别为发送，把文字传到 Windows。
7. Windows 粘贴文字，并在目标窗口焦点未变化时自动按一次回车。

微信输入法或其他支持语音输入的 Android 输入法也可使用相同思路，只需重新测量它们的语音按钮和回车按钮坐标。

## 6. 隐私与排错

- 不要公开 AirType Token、访问二维码或完整访问 URL。
- 不要公开无线 ADB 地址、配对码或真实设备序列号。
- 多设备时必须确认 DirectADB 选择了正确设备。
- 坐标偏移时先检查分辨率、DPI、屏幕方向和输入法键盘高度是否变化。
- 检测不到雷电设备时，按雷电官方教程执行 `adb devices`；必要时执行 `adb kill-server`、`adb start-server` 后再检测。
