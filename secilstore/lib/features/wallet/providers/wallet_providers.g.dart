// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$walletRepositoryHash() => r'ce9d4efa656f720d69c461aa3ea20a4732d1cc46';

/// See also [walletRepository].
@ProviderFor(walletRepository)
final walletRepositoryProvider = AutoDisposeProvider<WalletRepository>.internal(
  walletRepository,
  name: r'walletRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$walletRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WalletRepositoryRef = AutoDisposeProviderRef<WalletRepository>;
String _$walletSummaryHash() => r'43c9324a5d7eba7cbbeb10bdd581d75957b505d9';

/// See also [walletSummary].
@ProviderFor(walletSummary)
final walletSummaryProvider = AutoDisposeFutureProvider<WalletSummary>.internal(
  walletSummary,
  name: r'walletSummaryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$walletSummaryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WalletSummaryRef = AutoDisposeFutureProviderRef<WalletSummary>;
String _$transactionsHash() => r'52424755ceed39043bb0569f2e50dc40733bc825';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [transactions].
@ProviderFor(transactions)
const transactionsProvider = TransactionsFamily();

/// See also [transactions].
class TransactionsFamily extends Family<AsyncValue<List<WalletTransaction>>> {
  /// See also [transactions].
  const TransactionsFamily();

  /// See also [transactions].
  TransactionsProvider call(
    TransactionFilter filter,
  ) {
    return TransactionsProvider(
      filter,
    );
  }

  @override
  TransactionsProvider getProviderOverride(
    covariant TransactionsProvider provider,
  ) {
    return call(
      provider.filter,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'transactionsProvider';
}

/// See also [transactions].
class TransactionsProvider
    extends AutoDisposeFutureProvider<List<WalletTransaction>> {
  /// See also [transactions].
  TransactionsProvider(
    TransactionFilter filter,
  ) : this._internal(
          (ref) => transactions(
            ref as TransactionsRef,
            filter,
          ),
          from: transactionsProvider,
          name: r'transactionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$transactionsHash,
          dependencies: TransactionsFamily._dependencies,
          allTransitiveDependencies:
              TransactionsFamily._allTransitiveDependencies,
          filter: filter,
        );

  TransactionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filter,
  }) : super.internal();

  final TransactionFilter filter;

  @override
  Override overrideWith(
    FutureOr<List<WalletTransaction>> Function(TransactionsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TransactionsProvider._internal(
        (ref) => create(ref as TransactionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filter: filter,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<WalletTransaction>> createElement() {
    return _TransactionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionsProvider && other.filter == filter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TransactionsRef on AutoDisposeFutureProviderRef<List<WalletTransaction>> {
  /// The parameter `filter` of this provider.
  TransactionFilter get filter;
}

class _TransactionsProviderElement
    extends AutoDisposeFutureProviderElement<List<WalletTransaction>>
    with TransactionsRef {
  _TransactionsProviderElement(super.provider);

  @override
  TransactionFilter get filter => (origin as TransactionsProvider).filter;
}

String _$pendingTransactionsHash() =>
    r'08a401f8cf5e00909f03a6b1e27c29a2195dce08';

/// See also [pendingTransactions].
@ProviderFor(pendingTransactions)
final pendingTransactionsProvider =
    AutoDisposeFutureProvider<List<PendingTransaction>>.internal(
  pendingTransactions,
  name: r'pendingTransactionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pendingTransactionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PendingTransactionsRef
    = AutoDisposeFutureProviderRef<List<PendingTransaction>>;
String _$walletTabNotifierHash() => r'397e792626d6d20f8fbea6d64cc8b60b7d2922bb';

/// See also [WalletTabNotifier].
@ProviderFor(WalletTabNotifier)
final walletTabNotifierProvider =
    AutoDisposeNotifierProvider<WalletTabNotifier, int>.internal(
  WalletTabNotifier.new,
  name: r'walletTabNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$walletTabNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WalletTabNotifier = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
