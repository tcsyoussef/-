# IR TV Remote

Real infrared remote for Android phones that have a **built-in IR blaster**.

## APK

**Download:** [`dist/IR-TV-Remote.apk`](dist/IR-TV-Remote.apk)

https://github.com/tcsyoussef/-/raw/cursor/ir-tv-remote-apk-9168/dist/IR-TV-Remote.apk

```bash
adb install -r dist/IR-TV-Remote.apk
```

## How to use on your phone

1. Install the APK on a phone **with built-in IR** (infrared LED).
2. Open the app — it should say **IR blaster ready**.
3. Select **Haier** (default). If Power does nothing, try **Haier Alt**.
4. Point the phone’s IR LED at the TV and press buttons.

Without an IR blaster the app will refuse to send commands (no fake simulation).

## Brands

Haier, Haier Alt, Samsung, LG, Sony, Panasonic, TCL, Hisense, Sharp, Philips

## Build

```bash
./gradlew test assembleRelease
```
