# IR TV Remote

Android infrared TV remote control app with multi-brand command encoding.

## Build

```bash
./gradlew assembleDebug
./gradlew assembleRelease
./gradlew test
```

### Outputs

- Debug APK: `app/build/outputs/apk/debug/app-debug.apk`
- Release APK: `app/build/outputs/apk/release/app-release-unsigned.apk`

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
keytool -genkeypair -v -keystore ir-tv-remote.jks -keyalg RSA -keysize 2048 -validity 10000 -alias irremote
./gradlew assembleRelease
# Or configure signingConfigs in app/build.gradle.kts and produce a signed APK
jarsigner -verbose -sigalg SHA256withRSA -digestalg SHA-256 -keystore ir-tv-remote.jks app/build/outputs/apk/release/app-release-unsigned.apk irremote
zipalign -v 4 app/build/outputs/apk/release/app-release-unsigned.apk app-release.apk
```

## Install

```bash
adb install -r app/build/outputs/apk/debug/app-debug.apk
```
