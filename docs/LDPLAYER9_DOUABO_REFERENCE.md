# 雷电模拟器 9 + 豆包输入法参考配置

本文记录一套已经实际验证可用的雷电模拟器 + 豆包输入法 + QAA ADB Tap 配置，供其他用户快速参考。

> 这不是强制配置。不同模拟器版本、分辨率、DPI、输入法版本或键盘布局可能导致坐标不同，请以自己的实际界面为准。

## 已验证环境

- 雷电模拟器版本：`9.0.47`
- 模拟器已开启 Root
- 机型/分辨率预设：`手机版`
- 分辨率：`1080 × 1920`
- DPI：`480`
- CPU：`4 核（推荐）`
- 内存：`4096M（推荐）`
- 磁盘管理：`空间不够时，自动扩充`
- 磁盘共享：`System.vmdk 可写入`
- 输入法：豆包输入法
- 豆包输入法组件：`com.bytedance.android.doubaoime/.ImeService`

## 豆包输入法切换参考

在雷电 9.0.47 中，普通 `ime set` 可能显示 selected，但随后又被系统输入法切回。当前环境中使用 Root 直接写入默认输入法后已验证可用：

```bat
adb shell su -c "settings put secure default_input_method com.bytedance.android.doubaoime/.ImeService"
```

确认当前默认输入法：

```bat
adb shell settings get secure default_input_method
```

正常返回：

```text
com.bytedance.android.doubaoime/.ImeService
```

确认当前实际运行的输入法：

```bat
adb shell dumpsys input_method | findstr /i "mCurMethodId mSelectedMethodId"
```

已验证返回：

```text
mCurMethodId=com.bytedance.android.doubaoime/.ImeService
```

## QAA ADB Tap 坐标参考

以下坐标基于：

- 雷电模拟器 `9.0.47`
- Android 内部分辨率 `1080 × 1920`
- DPI `480`
- 豆包输入法当前键盘布局

并已实际测试可以正常点击。

| 数字小键盘 | 目标按钮 | Android 坐标 |
| --- | --- | --- |
| `-` | 豆包输入法“点击说话” | `X=770, Y=1195` |
| `+` | 豆包输入法“换行” | `X=965, Y=1740` |

QAA ADB Tap 中可参考填写：

```text
减号（-）：770,1195
加号（+）：965,1740
```

也可以直接用 ADB 验证坐标：

```bat
adb shell input tap 770 1195
adb shell input tap 965 1740
```

第一条应点击豆包输入法的“点击说话”，第二条应点击右下角“换行”。

## 使用说明

推荐的组合操作是：

1. 数字小键盘 `-` 触发 ADB Tap，点击豆包输入法“点击说话”。
2. 完成语音输入后，数字小键盘 `+` 触发 ADB Tap，点击豆包输入法“换行/回车”位置。
3. AirType 根据当前工作流继续完成文字发送到 Windows 端。

## 坐标失效时

坐标是 Android 内部坐标，不是 Windows 桌面坐标。只要修改了以下任一项，都建议重新校准：

- 模拟器分辨率
- DPI
- 豆包输入法版本
- 键盘布局或键盘高度
- 横竖屏方向

当前 `770,1195` 和 `965,1740` 仅作为上述已验证配置下的参考值。