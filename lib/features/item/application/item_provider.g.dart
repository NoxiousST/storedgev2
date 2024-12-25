// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$iCollectionRefHash() => r'1c5896ae9edb3a1450cfa2991f932f6d60f4099d';

/// See also [iCollectionRef].
@ProviderFor(iCollectionRef)
final iCollectionRefProvider =
    AutoDisposeProvider<CollectionReference<Item>>.internal(
  iCollectionRef,
  name: r'iCollectionRefProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$iCollectionRefHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ICollectionRefRef = AutoDisposeProviderRef<CollectionReference<Item>>;
String _$iStorageRefHash() => r'21ab06bab734695c05ffa63dda3d42995240acd3';

/// See also [iStorageRef].
@ProviderFor(iStorageRef)
final iStorageRefProvider = AutoDisposeProvider<Reference>.internal(
  iStorageRef,
  name: r'iStorageRefProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$iStorageRefHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IStorageRefRef = AutoDisposeProviderRef<Reference>;
String _$iDocumentRefHash() => r'fee90052fd95afa0e4aaba8304c7f2b361bb1052';

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

/// See also [iDocumentRef].
@ProviderFor(iDocumentRef)
const iDocumentRefProvider = IDocumentRefFamily();

/// See also [iDocumentRef].
class IDocumentRefFamily extends Family<DocumentReference<Item>> {
  /// See also [iDocumentRef].
  const IDocumentRefFamily();

  /// See also [iDocumentRef].
  IDocumentRefProvider call(
    String id,
  ) {
    return IDocumentRefProvider(
      id,
    );
  }

  @override
  IDocumentRefProvider getProviderOverride(
    covariant IDocumentRefProvider provider,
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
  String? get name => r'iDocumentRefProvider';
}

/// See also [iDocumentRef].
class IDocumentRefProvider
    extends AutoDisposeProvider<DocumentReference<Item>> {
  /// See also [iDocumentRef].
  IDocumentRefProvider(
    String id,
  ) : this._internal(
          (ref) => iDocumentRef(
            ref as IDocumentRefRef,
            id,
          ),
          from: iDocumentRefProvider,
          name: r'iDocumentRefProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$iDocumentRefHash,
          dependencies: IDocumentRefFamily._dependencies,
          allTransitiveDependencies:
              IDocumentRefFamily._allTransitiveDependencies,
          id: id,
        );

  IDocumentRefProvider._internal(
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
    DocumentReference<Item> Function(IDocumentRefRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IDocumentRefProvider._internal(
        (ref) => create(ref as IDocumentRefRef),
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
  AutoDisposeProviderElement<DocumentReference<Item>> createElement() {
    return _IDocumentRefProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IDocumentRefProvider && other.id == id;
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
mixin IDocumentRefRef on AutoDisposeProviderRef<DocumentReference<Item>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _IDocumentRefProviderElement
    extends AutoDisposeProviderElement<DocumentReference<Item>>
    with IDocumentRefRef {
  _IDocumentRefProviderElement(super.provider);

  @override
  String get id => (origin as IDocumentRefProvider).id;
}

String _$itemRepositoryHash() => r'232fc21cb3fb12f76a6b93bc5a1afaf9306d54a3';

/// See also [itemRepository].
@ProviderFor(itemRepository)
final itemRepositoryProvider = Provider<ItemRepository>.internal(
  itemRepository,
  name: r'itemRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$itemRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ItemRepositoryRef = ProviderRef<ItemRepository>;
String _$itemsHash() => r'587bdd9f22139bf5b528da8c6ad7aa36b8182e38';

/// See also [items].
@ProviderFor(items)
final itemsProvider = AutoDisposeStreamProvider<List<Item>>.internal(
  items,
  name: r'itemsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$itemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ItemsRef = AutoDisposeStreamProviderRef<List<Item>>;
String _$itemHash() => r'dc5af1775fc748cba07f655acc516ab8ce401177';

/// See also [item].
@ProviderFor(item)
const itemProvider = ItemFamily();

/// See also [item].
class ItemFamily extends Family<AsyncValue<Item>> {
  /// See also [item].
  const ItemFamily();

  /// See also [item].
  ItemProvider call(
    String id,
  ) {
    return ItemProvider(
      id,
    );
  }

  @override
  ItemProvider getProviderOverride(
    covariant ItemProvider provider,
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
  String? get name => r'itemProvider';
}

/// See also [item].
class ItemProvider extends AutoDisposeStreamProvider<Item> {
  /// See also [item].
  ItemProvider(
    String id,
  ) : this._internal(
          (ref) => item(
            ref as ItemRef,
            id,
          ),
          from: itemProvider,
          name: r'itemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$itemHash,
          dependencies: ItemFamily._dependencies,
          allTransitiveDependencies: ItemFamily._allTransitiveDependencies,
          id: id,
        );

  ItemProvider._internal(
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
    Stream<Item> Function(ItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ItemProvider._internal(
        (ref) => create(ref as ItemRef),
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
  AutoDisposeStreamProviderElement<Item> createElement() {
    return _ItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemProvider && other.id == id;
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
mixin ItemRef on AutoDisposeStreamProviderRef<Item> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ItemProviderElement extends AutoDisposeStreamProviderElement<Item>
    with ItemRef {
  _ItemProviderElement(super.provider);

  @override
  String get id => (origin as ItemProvider).id;
}

String _$itemDocHash() => r'4f3de7be1cb120bffd9408c008510f6cabed248b';

/// See also [itemDoc].
@ProviderFor(itemDoc)
const itemDocProvider = ItemDocFamily();

/// See also [itemDoc].
class ItemDocFamily extends Family<AsyncValue<Item>> {
  /// See also [itemDoc].
  const ItemDocFamily();

  /// See also [itemDoc].
  ItemDocProvider call(
    dynamic id,
  ) {
    return ItemDocProvider(
      id,
    );
  }

  @override
  ItemDocProvider getProviderOverride(
    covariant ItemDocProvider provider,
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
  String? get name => r'itemDocProvider';
}

/// See also [itemDoc].
class ItemDocProvider extends AutoDisposeFutureProvider<Item> {
  /// See also [itemDoc].
  ItemDocProvider(
    dynamic id,
  ) : this._internal(
          (ref) => itemDoc(
            ref as ItemDocRef,
            id,
          ),
          from: itemDocProvider,
          name: r'itemDocProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itemDocHash,
          dependencies: ItemDocFamily._dependencies,
          allTransitiveDependencies: ItemDocFamily._allTransitiveDependencies,
          id: id,
        );

  ItemDocProvider._internal(
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
    FutureOr<Item> Function(ItemDocRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ItemDocProvider._internal(
        (ref) => create(ref as ItemDocRef),
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
  AutoDisposeFutureProviderElement<Item> createElement() {
    return _ItemDocProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemDocProvider && other.id == id;
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
mixin ItemDocRef on AutoDisposeFutureProviderRef<Item> {
  /// The parameter `id` of this provider.
  dynamic get id;
}

class _ItemDocProviderElement extends AutoDisposeFutureProviderElement<Item>
    with ItemDocRef {
  _ItemDocProviderElement(super.provider);

  @override
  dynamic get id => (origin as ItemDocProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
