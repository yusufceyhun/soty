# soty

Production-grade Flutter implementation of the **SeçilStore Mobile Case Study**.

This repository contains a full end-to-end mobile experience: OTP authentication, wallet transactions, pending rewards flow, campaign selection logic, and QR/barcode payment generation.

## Repository Structure

- `secilstore/` — Flutter app source code (feature-first architecture)

## Engineering Principles

- Clean architecture boundaries: `UI -> Provider/Notifier -> Repository -> Network`
- Strong typing and immutable models (`Freezed`)
- Explicit error mapping (`DioException -> AppException`)
- Secure token handling (`flutter_secure_storage`)
- Testable state logic (Riverpod providers/notifiers)
- Production safety defaults (debug logs and Firebase guarded by runtime flags)

## Stack

- Flutter 3.16+
- Dart 3.2+
- Riverpod (code generation)
- GoRouter
- Dio
- Freezed + json_serializable
- Firebase Analytics / Crashlytics / Remote Config
- qr_flutter / barcode_widget

## Quick Start

```bash
cd secilstore
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Test credentials:

- Phone: `905998881122`
- OTP: `111111`

## Quality Gates

```bash
cd secilstore
flutter analyze lib/
flutter test
flutter build apk --debug
flutter build ios --debug --no-codesign
```
