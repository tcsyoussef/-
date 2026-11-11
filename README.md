# IR TV Remote

## APK

**Installable signed APK:** [`dist/IR-TV-Remote.apk`](dist/IR-TV-Remote.apk)

```bash
adb install -r dist/IR-TV-Remote.apk
```

Package: `com.irremote.tv` · minSdk 24 · targetSdk 34

## Build from source

```bash
./gradlew assembleRelease
# output: app/build/outputs/apk/release/app-release.apk
```

Release signing uses local `release.keystore` + `keystore.properties` (gitignored).

## Limitations

Physical IR TV control and USB-C IR adapters are **untested** in this environment. Without a built-in IR emitter the app runs in simulation mode.
