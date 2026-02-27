// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$storeRepositoryHash() => r'4ec3f1309d07f35f015fb2e97ff73750f08cbf6c';

/// See also [storeRepository].
@ProviderFor(storeRepository)
final storeRepositoryProvider = AutoDisposeProvider<StoreRepository>.internal(
  storeRepository,
  name: r'storeRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$storeRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StoreRepositoryRef = AutoDisposeProviderRef<StoreRepository>;
String _$activeCampaignsHash() => r'caf02e6c1a19cfe8b2615eed2312e8da587552e1';

/// See also [activeCampaigns].
@ProviderFor(activeCampaigns)
final activeCampaignsProvider =
    AutoDisposeFutureProvider<List<Campaign>>.internal(
  activeCampaigns,
  name: r'activeCampaignsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeCampaignsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveCampaignsRef = AutoDisposeFutureProviderRef<List<Campaign>>;
String _$storeSelectionNotifierHash() =>
    r'28252912a5922f166b1011b43307a42304be0f88';

/// See also [StoreSelectionNotifier].
@ProviderFor(StoreSelectionNotifier)
final storeSelectionNotifierProvider = AutoDisposeNotifierProvider<
    StoreSelectionNotifier, CampaignSelectionState>.internal(
  StoreSelectionNotifier.new,
  name: r'storeSelectionNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$storeSelectionNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StoreSelectionNotifier = AutoDisposeNotifier<CampaignSelectionState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
