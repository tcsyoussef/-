# LEVEL UP

Private 365-day personal transformation Android app (offline-first).

## Stack

- Flutter + Dart
- Clean Architecture folders under `lib/`
- Drift (SQLite), Riverpod, go_router
- Local notifications, backup/restore
- No accounts, backend, or ads

## Roadmap

- Start: **2026-11-27** (Day 1 preloaded)
- End: **2027-11-26**
- Goals: Fitness, English, Repair Academy, Appearance

## Build

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter build apk --release
```

Release APK:

`build/app/outputs/flutter-apk/app-release.apk`

Signed with debug keys for personal installability (credentials outside VCS).

## Notes

- Emulator/device UI verification depends on available Android devices.
- Notifications require runtime permission on Android 13+.
