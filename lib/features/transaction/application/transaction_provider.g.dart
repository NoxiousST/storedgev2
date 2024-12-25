// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tCollectionRefHash() => r'13794553dd35b38b9619b2da3357abdfd6bf4ef9';

/// See also [tCollectionRef].
@ProviderFor(tCollectionRef)
final tCollectionRefProvider =
    AutoDisposeProvider<CollectionReference<Transaksi>>.internal(
  tCollectionRef,
  name: r'tCollectionRefProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tCollectionRefHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TCollectionRefRef
    = AutoDisposeProviderRef<CollectionReference<Transaksi>>;
String _$tDocumentRefHash() => r'bdb6552744967f35d06e7451ab331b92ad5d2d1c';

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

/// See also [tDocumentRef].
@ProviderFor(tDocumentRef)
const tDocumentRefProvider = TDocumentRefFamily();

/// See also [tDocumentRef].
class TDocumentRefFamily extends Family<DocumentReference<Transaksi>> {
  /// See also [tDocumentRef].
  const TDocumentRefFamily();

  /// See also [tDocumentRef].
  TDocumentRefProvider call(
    String id,
  ) {
    return TDocumentRefProvider(
      id,
    );
  }

  @override
  TDocumentRefProvider getProviderOverride(
    covariant TDocumentRefProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'tDocumentRefProvider';
}

/// See also [tDocumentRef].
class TDocumentRefProvider
    extends AutoDisposeProvider<DocumentReference<Transaksi>> {
  /// See also [tDocumentRef].
  TDocumentRefProvider(
    String id,
  ) : this._internal(
          (ref) => tDocumentRef(
            ref as TDocumentRefRef,
            id,
          ),
          from: tDocumentRefProvider,
          name: r'tDocumentRefProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tDocumentRefHash,
          dependencies: TDocumentRefFamily._dependencies,
          allTransitiveDependencies:
              TDocumentRefFamily._allTransitiveDependencies,
          id: id,
        );

  TDocumentRefProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    DocumentReference<Transaksi> Function(TDocumentRefRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TDocumentRefProvider._internal(
        (ref) => create(ref as TDocumentRefRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<DocumentReference<Transaksi>> createElement() {
    return _TDocumentRefProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TDocumentRefProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TDocumentRefRef on AutoDisposeProviderRef<DocumentReference<Transaksi>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _TDocumentRefProviderElement
    extends AutoDisposeProviderElement<DocumentReference<Transaksi>>
    with TDocumentRefRef {
  _TDocumentRefProviderElement(super.provider);

  @override
  String get id => (origin as TDocumentRefProvider).id;
}

String _$transactionRepositoryHash() =>
    r'a1be472c20954c5363362ebd6a4d119bdea0e180';

/// See also [transactionRepository].
@ProviderFor(transactionRepository)
final transactionRepositoryProvider = Provider<TransactionRepository>.internal(
  transactionRepository,
  name: r'transactionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$transactionRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TransactionRepositoryRef = ProviderRef<TransactionRepository>;
String _$transactionsHash() => r'867d316a94a4287c88bc689e07a9ab158a57a6c1';

/// See also [transactions].
@ProviderFor(transactions)
final transactionsProvider =
    AutoDisposeStreamProvider<List<Transaksi>>.internal(
  transactions,
  name: r'transactionsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$transactionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TransactionsRef = AutoDisposeStreamProviderRef<List<Transaksi>>;
String _$itemTransactionsHash() => r'9eca4625c44262ea61c03e2ca12d05d3694fb1de';

/// See also [itemTransactions].
@ProviderFor(itemTransactions)
const itemTransactionsProvider = ItemTransactionsFamily();

/// See also [itemTransactions].
class ItemTransactionsFamily extends Family<AsyncValue<List<Transaksi>>> {
  /// See also [itemTransactions].
  const ItemTransactionsFamily();

  /// See also [itemTransactions].
  ItemTransactionsProvider call(
    String itemId,
  ) {
    return ItemTransactionsProvider(
      itemId,
    );
  }

  @override
  ItemTransactionsProvider getProviderOverride(
    covariant ItemTransactionsProvider provider,
  ) {
    return call(
      provider.itemId,
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
  String? get name => r'itemTransactionsProvider';
}

/// See also [itemTransactions].
class ItemTransactionsProvider
    extends AutoDisposeStreamProvider<List<Transaksi>> {
  /// See also [itemTransactions].
  ItemTransactionsProvider(
    String itemId,
  ) : this._internal(
          (ref) => itemTransactions(
            ref as ItemTransactionsRef,
            itemId,
          ),
          from: itemTransactionsProvider,
          name: r'itemTransactionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itemTransactionsHash,
          dependencies: ItemTransactionsFamily._dependencies,
          allTransitiveDependencies:
              ItemTransactionsFamily._allTransitiveDependencies,
          itemId: itemId,
        );

  ItemTransactionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.itemId,
  }) : super.internal();

  final String itemId;

  @override
  Override overrideWith(
    Stream<List<Transaksi>> Function(ItemTransactionsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ItemTransactionsProvider._internal(
        (ref) => create(ref as ItemTransactionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        itemId: itemId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Transaksi>> createElement() {
    return _ItemTransactionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemTransactionsProvider && other.itemId == itemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, itemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ItemTransactionsRef on AutoDisposeStreamProviderRef<List<Transaksi>> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _ItemTransactionsProviderElement
    extends AutoDisposeStreamProviderElement<List<Transaksi>>
    with ItemTransactionsRef {
  _ItemTransactionsProviderElement(super.provider);

  @override
  String get itemId => (origin as ItemTransactionsProvider).itemId;
}

String _$transactionHash() => r'9707a86dde751e5f84bce856125a75bdb798e917';

/// See also [transaction].
@ProviderFor(transaction)
const transactionProvider = TransactionFamily();

/// See also [transaction].
class TransactionFamily extends Family<AsyncValue<Transaksi>> {
  /// See also [transaction].
  const TransactionFamily();

  /// See also [transaction].
  TransactionProvider call(
    String id,
  ) {
    return TransactionProvider(
      id,
    );
  }

  @override
  TransactionProvider getProviderOverride(
    covariant TransactionProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'transactionProvider';
}

/// See also [transaction].
class TransactionProvider extends AutoDisposeStreamProvider<Transaksi> {
  /// See also [transaction].
  TransactionProvider(
    String id,
  ) : this._internal(
          (ref) => transaction(
            ref as TransactionRef,
            id,
          ),
          from: transactionProvider,
          name: r'transactionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$transactionHash,
          dependencies: TransactionFamily._dependencies,
          allTransitiveDependencies:
              TransactionFamily._allTransitiveDependencies,
          id: id,
        );

  TransactionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Stream<Transaksi> Function(TransactionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TransactionProvider._internal(
        (ref) => create(ref as TransactionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Transaksi> createElement() {
    return _TransactionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TransactionRef on AutoDisposeStreamProviderRef<Transaksi> {
  /// The parameter `id` of this provider.
  String get id;
}

class _TransactionProviderElement
    extends AutoDisposeStreamProviderElement<Transaksi> with TransactionRef {
  _TransactionProviderElement(super.provider);

  @override
  String get id => (origin as TransactionProvider).id;
}

String _$transactionDocHash() => r'999fb44cb6aeab6a1101fd221a74b0651adfaaae';

/// See also [transactionDoc].
@ProviderFor(transactionDoc)
const transactionDocProvider = TransactionDocFamily();

/// See also [transactionDoc].
class TransactionDocFamily extends Family<AsyncValue<Transaksi>> {
  /// See also [transactionDoc].
  const TransactionDocFamily();

  /// See also [transactionDoc].
  TransactionDocProvider call(
    dynamic id,
  ) {
    return TransactionDocProvider(
      id,
    );
  }

  @override
  TransactionDocProvider getProviderOverride(
    covariant TransactionDocProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'transactionDocProvider';
}

/// See also [transactionDoc].
class TransactionDocProvider extends AutoDisposeFutureProvider<Transaksi> {
  /// See also [transactionDoc].
  TransactionDocProvider(
    dynamic id,
  ) : this._internal(
          (ref) => transactionDoc(
            ref as TransactionDocRef,
            id,
          ),
          from: transactionDocProvider,
          name: r'transactionDocProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$transactionDocHash,
          dependencies: TransactionDocFamily._dependencies,
          allTransitiveDependencies:
              TransactionDocFamily._allTransitiveDependencies,
          id: id,
        );

  TransactionDocProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final dynamic id;

  @override
  Override overrideWith(
    FutureOr<Transaksi> Function(TransactionDocRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TransactionDocProvider._internal(
        (ref) => create(ref as TransactionDocRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Transaksi> createElement() {
    return _TransactionDocProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionDocProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TransactionDocRef on AutoDisposeFutureProviderRef<Transaksi> {
  /// The parameter `id` of this provider.
  dynamic get id;
}

class _TransactionDocProviderElement
    extends AutoDisposeFutureProviderElement<Transaksi> with TransactionDocRef {
  _TransactionDocProviderElement(super.provider);

  @override
  dynamic get id => (origin as TransactionDocProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
