# IR TV Remote

Android infrared TV remote control app with multi-brand command encoding.

## Build

```bash
./gradlew assembleDebug
./gradlew assembleRelease
./gradlew test
```

### Outputs

- Debug APK: `dist/app-debug.apk` (`app/build/outputs/apk/debug/app-debug.apk`)
- Signed release APK: `dist/app-release.apk` (`app/build/outputs/apk/release/app-release.apk`)

Create `release.keystore` + `keystore.properties` (gitignored) to enable release signing.

## Features

- Power, mute, volume, channel, navigation, menu/home/back/input, and number pad
- Brand profiles: Samsung, LG, Sony, Panasonic, TCL, Hisense, Sharp, Philips
- NEC / SIRC / RC5 / Panasonic IR pattern encoding
- Built-in IR detection via `ConsumerIrManager`
- Simulation mode when no IR emitter is present

## Known limitations

- Physical TV control has **not** been tested against a real IR emitter or TV in this environment
- USB-C IR adapter compatibility is **not** implemented or verified
- IR codes are common defaults and may not match every model/region

## Signing a release APK

```bash
keytool -genkeypair -v -keystore release.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias irremote
cat > keystore.properties <<'EOF'
storePassword=YOUR_STORE_PASSWORD
keyAlias=irremote
keyPassword=YOUR_KEY_PASSWORD
EOF
./gradlew assembleRelease
# Output: app/build/outputs/apk/release/app-release.apk
```

`app/build.gradle.kts` already wires `signingConfigs.release` when both files exist.

## Install

```bash
adb install -r app/build/outputs/apk/debug/app-debug.apk
```
