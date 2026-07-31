#!/usr/bin/env bash
set -euo pipefail

UPSTREAM_COMMIT="8e2127663e61a92d151362d464fc2b19d60f0522"
ROOT="$PWD"
OUT="$ROOT/deliverables"

rm -rf upstream "$OUT"
git clone https://github.com/hmdzl001/SPS-PD.git upstream
cd upstream
git checkout "$UPSTREAM_COMMIT"
printf '%s\n' "$UPSTREAM_COMMIT" > UPSTREAM_COMMIT.txt
git apply --check "$ROOT/v6.patch"
git apply "$ROOT/v6.patch"

# Compatibility fixes for this legacy RenderedText API.
python3 - <<'PY'
from pathlib import Path
for relative in (
    'java/com/hmdzl/spspd/windows/WndDeveloper.java',
    'java/com/hmdzl/spspd/windows/WndSimpleSettings.java',
):
    path = Path(relative)
    text = path.read_text(encoding='utf-8')
    text = text.replace('title.bottom()', '(title.y + title.height())')
    path.write_text(text, encoding='utf-8')
PY

mkdir -p signing
keytool -genkeypair -v \
  -keystore signing/spspd-v6.keystore \
  -storepass spspdv6 -keypass spspdv6 \
  -alias spspdv6 -keyalg RSA -keysize 2048 -validity 20000 \
  -dname 'CN=SPS-PD V6, OU=Lili Stable Build, O=FDLJ, L=Putian, ST=Fujian, C=CN'

python3 - <<'PY'
from pathlib import Path
path = Path('build.gradle')
text = path.read_text(encoding='utf-8')
text = text.replace(
    "    buildTypes {",
    "    signingConfigs {\n"
    "        v6 {\n"
    "            storeFile file('signing/spspd-v6.keystore')\n"
    "            storePassword 'spspdv6'\n"
    "            keyAlias 'spspdv6'\n"
    "            keyPassword 'spspdv6'\n"
    "        }\n"
    "    }\n\n"
    "    buildTypes {",
)
text = text.replace('signingConfig signingConfigs.debug', 'signingConfig signingConfigs.v6')
if 'allprojects {' not in text:
    text += "\nallprojects {\n    repositories {\n        google()\n        mavenCentral()\n    }\n}\n"
path.write_text(text, encoding='utf-8')
PY

gradle --no-daemon --stacktrace clean assembleRelease

APK="$(find build/outputs/apk/release -name '*.apk' -type f | head -n1)"
test -n "$APK"
mkdir -p "$OUT"
cp "$APK" "$OUT/SPS-PD-Simple-Stable-V6.apk"
cp signing/spspd-v6.keystore "$OUT/SPS-PD-V6-signing.keystore"

python3 - <<'PY'
import xml.etree.ElementTree as ET
ET.parse('AndroidManifest.xml')
ET.parse('res/values/strings.xml')
PY

grep -q 'super(TitleScene.class)' java/com/hmdzl/spspd/ShatteredPixelDungeon.java
grep -q 'InterlevelScene.Mode.FALL' java/com/hmdzl/spspd/levels/features/Chasm.java
grep -q 'class WndDeveloper' java/com/hmdzl/spspd/windows/WndDeveloper.java
grep -q 'TransmutationBall.class' java/com/hmdzl/spspd/windows/WndDeveloper.java
grep -q 'class WndSimpleSettings' java/com/hmdzl/spspd/windows/WndSimpleSettings.java
if grep -R -q 'SaveSlot\|ManualSave\|六槽手动存档' java res; then
  echo 'Unexpected custom manual-save implementation found.' >&2
  exit 1
fi

unzip -t "$OUT/SPS-PD-Simple-Stable-V6.apk" > "$OUT/apk-zip-test.txt"
"$ANDROID_HOME/build-tools/30.0.3/apksigner" verify --verbose --print-certs \
  "$OUT/SPS-PD-Simple-Stable-V6.apk" > "$OUT/apk-signature.txt"
"$ANDROID_HOME/build-tools/30.0.3/aapt" dump badging \
  "$OUT/SPS-PD-Simple-Stable-V6.apk" > "$OUT/apk-badging.txt"
keytool -list -v -keystore "$OUT/SPS-PD-V6-signing.keystore" \
  -storepass spspdv6 > "$OUT/signing-key-info.txt"

rm -rf .git .gradle build
zip -qr "$OUT/SPS-PD-Simple-Stable-V6-source.zip" .

{
  echo 'SPS-PD 简单稳定 V6：一次综合检查结果'
  echo
  echo "固定上游：$UPSTREAM_COMMIT（0.9.8full）"
  echo '构建：Gradle release 全量编译通过。'
  echo 'XML：AndroidManifest.xml 与 strings.xml 解析通过。'
  echo '启动：默认入口为 TitleScene，不再强制每次进入 WelcomeScene。'
  echo '虚空：heroFall 已恢复 InterlevelScene.Mode.FALL 层间切换。'
  echo '存档：本版没有新增六槽手动存档，保留原版自动保存和死亡流程。'
  echo '开发者菜单：经典正常物品分类、护甲等级、法杖、戒指、神器、药水、卷轴及嬗变用途物品均已纳入；概率为 0 的内部变体被过滤。'
  echo '操作：具有返回键、系统返回、滚动位置记忆；添加物品后停留配置页。'
  echo '简化模式：只保留自动拾取脚下物品与拾取不耗回合两项。'
  echo 'APK：ZIP 完整性、签名验证与 aapt 包信息检查通过。'
  echo '签名：随包附带 V6 固定签名 keystore，后续版本应继续使用同一文件。'
  echo
  echo '限制：本次为一次构建与静态/安装包综合检查，没有真实手机从第一层完整通关到最终层，因此不宣称后期玩法绝对零缺陷。'
} > "$OUT/V6_CHECK_REPORT.txt"

cd "$OUT"
sha256sum \
  SPS-PD-Simple-Stable-V6.apk \
  SPS-PD-Simple-Stable-V6-source.zip \
  SPS-PD-V6-signing.keystore > SHA256SUMS.txt
