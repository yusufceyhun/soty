// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$paymentRepositoryHash() => r'0e2c562d5ad816c84c9e0117ef1abfd1f946132b';

/// See also [paymentRepository].
@ProviderFor(paymentRepository)
final paymentRepositoryProvider =
    AutoDisposeProvider<PaymentRepository>.internal(
  paymentRepository,
  name: r'paymentRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$paymentRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PaymentRepositoryRef = AutoDisposeProviderRef<PaymentRepository>;
String _$paymentNotifierHash() => r'56e7313467fa0d197e1fe00c40054f9b165c5276';

/// See also [PaymentNotifier].
@ProviderFor(PaymentNotifier)
final paymentNotifierProvider = AutoDisposeNotifierProvider<PaymentNotifier,
    AsyncValue<PaymentCode?>>.internal(
  PaymentNotifier.new,
  name: r'paymentNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$paymentNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PaymentNotifier = AutoDisposeNotifier<AsyncValue<PaymentCode?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
