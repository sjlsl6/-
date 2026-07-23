# Security

## Network exposure

AirType 面向可信局域网使用。不要将服务端口直接暴露到公网，也不要把带 Token 的访问 URL 转发给不受信任的人。

## ADB

ADB 具有较高设备控制权限。仅连接你拥有或明确获授权控制的 Android 设备/模拟器。无线调试配对码、ADB 地址和设备序列号都应视为本地运行信息。

## Downloads

DirectADB 的“一次性准备 ADB”逻辑使用固定来源与 SHA-256 校验后再提取所需 ADB 文件。修改下载 URL、版本或校验值时，应重新核验来源与许可证。

## Reporting

公开 Issue 中不要粘贴真实 Token、无线调试配对码、设备序列号、个人目录、账号信息或完整配置文件。安全问题应只提供最小化复现信息。
