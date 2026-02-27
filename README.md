# soty

SeçilStore Flutter mobile case study implementation with production-grade architecture and API-first behavior.

## Scope

- OTP authentication flow (`/login` -> `/otp` -> `/wallet`)
- Wallet summary, filtered transactions, pending rewards
- Store campaign selection with combinable/non-combinable business rules
- Payment QR/Barcode generation with 60-second refresh cycle

## Tech Stack

- Flutter 3.16+
- Dart 3.2+
- Riverpod (code generation)
- GoRouter
- Dio
- Freezed + json_serializable
- Firebase Analytics / Crashlytics / Remote Config
- qr_flutter / barcode_widget

## Architecture

- Feature-first structure under `secilstore/lib/features`
- Layering: `UI -> Notifier/Provider -> Repository -> Network`
- Domain models are immutable (`Freezed`)
- Typed error mapping (`DioException -> AppException`)
- Token storage via `flutter_secure_storage`

## API Contracts (Postman-aligned)

Postman collection path: `secilstore/.project_docs/postman_collection.json`

- `POST /Mobile/v1/Auth/SignIn`
- `GET /Mobile/v1/Wallet/Brands/{brandId}/Summary`
- `GET /Mobile/v1/Wallet/Brands/{brandId}/Transactions?FilterType={1|2|3}`
- `POST /Mobile/v1/Sotier/GetWaitingRewardCoin`
- `GET /Mobile/v1/Campaign/GetActiveCampaign/{brandId}`
- `POST /Mobile/v1/Campaign/GeneratePaymentQrCodeWithSotyCoinsAndCampaigns`

## Data Semantics

- `totalAvailableCoin`: total wallet coin
- `totalAvailableTransferCoin`: spendable/transferable coin

The app renders both values explicitly to avoid ambiguity in wallet, store, and profile flows.

## Local Setup

```bash
cd secilstore
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Test credentials:

- Phone: `905998881122`
- OTP: `111111`

## Verification

```bash
cd secilstore
flutter analyze lib/
flutter test
flutter build apk --debug
flutter build ios --debug --no-codesign
```
