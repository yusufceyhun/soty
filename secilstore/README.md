# SeçilStore - Flutter Mobile Case Study

A production-quality Flutter application built against the SeçilStore case requirements.

## Scope Delivered

### Authentication
- `/login`: phone input with validation and loading states
- `/otp`: 6-digit OTP flow, timer, retry handling, error messaging
- Successful verification routes user to `/wallet`

### Wallet
- `/wallet`: total and available coin balances
- Tabbed transaction views:
  - Tümü
  - Bekleyen
  - Kazandıklarım
  - Harcadıklarım
- Pull-to-refresh per active tab/provider
- Skeleton loading, explicit empty state, retryable error state

### Pending Transactions
- `POST /Mobile/v1/Sotier/GetWaitingRewardCoin`
- Parses nested API payload safely
- Online approval duration banner (`approveDuration`)
- Per-item countdown timer
- Expiry triggers state refresh to sync with other tabs

### Store
- `/store`: custom coin usage selector (`%25/%50/%75/%100`)
- Real-time coin amount calculation from **available** balance
- Balance-aware disabling and inline warning
- Campaign list with:
  - campaign name
  - discount label
  - combinable/non-combinable badge
  - validity date
- Conflict-resolution dialogs for campaign selection scenarios
- Selected campaigns rendered as removable chips

### Payment
- `/payment`: QR / Barcode tabbed display
- Code generation via API
- 60-second countdown and automatic regeneration
- Manual "Kodu Yenile"
- Coin and campaign summary rendering

## Architecture

```
lib/
  app/
  core/
  features/
    auth/
    wallet/
    store/
    payment/
    profile/
```

### Layering
- **UI layer**: rendering + interaction dispatch
- **Provider/Notifier layer**: state transitions and business rules
- **Repository layer**: API integration + response normalization
- **Core layer**: network, errors, storage, shared widgets/constants

## Technology Stack

- Flutter 3.16+
- Dart 3.2+
- Riverpod + riverpod_generator
- GoRouter
- Dio
- Freezed + json_serializable
- Firebase Analytics / Crashlytics / Remote Config
- qr_flutter
- barcode_widget

## Runtime Controls

Firebase is disabled by default.

```bash
flutter run --dart-define=ENABLE_FIREBASE=true
```

Optional debug logs:

```bash
flutter run \
  --dart-define=ENABLE_NETWORK_LOGS=true \
  --dart-define=VERBOSE_NETWORK_LOGS=true \
  --dart-define=ENABLE_ROUTER_LOGS=true
```

## Local Setup

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Test credentials:
- Phone: `905998881122`
- OTP: `111111`

## Verification Commands

```bash
flutter analyze lib/
flutter test
flutter build apk --debug
flutter build ios --debug --no-codesign
```

## Notes

- API base URL: `https://stage-api.soty.io`
- Brand ID: `550e8400-e29b-41d4-a716-446655440000`
