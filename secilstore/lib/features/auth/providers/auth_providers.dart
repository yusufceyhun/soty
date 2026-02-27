import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/app_exception.dart';
import '../../../core/providers/core_providers.dart';
import '../data/auth_repository.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(
    ref.watch(dioClientProvider),
    ref.watch(secureStorageProvider),
  );
}

@riverpod
Future<bool> authState(Ref ref) async {
  final token = await ref.watch(secureStorageProvider).getAccessToken();
  return token != null;
}

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<bool> requestOtp(String phone) async {
    state = const AsyncLoading();
    try {
      await ref.read(authRepositoryProvider).requestOtp(phone);
      state = const AsyncData(null);
      return true;
    } on AppException catch (e, st) {
      state = AsyncError(e, st);
      return false;
    } catch (e, st) {
      state = AsyncError(const UnknownException(), st);
      return false;
    }
  }

  Future<bool> verifyOtp(String phone, String otp) async {
    state = const AsyncLoading();
    try {
      await ref.read(authRepositoryProvider).verifyOtp(phone, otp);
      ref.invalidate(authStateProvider);
      await ref.read(authStateProvider.future);
      state = const AsyncData(null);
      return true;
    } on AppException catch (e, st) {
      state = AsyncError(e, st);
      return false;
    } catch (e, st) {
      state = AsyncError(const UnknownException(), st);
      return false;
    }
  }

  void clearError() {
    state = const AsyncData(null);
  }
}
