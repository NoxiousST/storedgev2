// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sCollectionRefHash() => r'b60315ad09f51ae252f1f832eb2ec5ff0e285183';

/// See also [sCollectionRef].
@ProviderFor(sCollectionRef)
final sCollectionRefProvider =
    AutoDisposeProvider<CollectionReference<Supplier>>.internal(
  sCollectionRef,
  name: r'sCollectionRefProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sCollectionRefHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SCollectionRefRef
    = AutoDisposeProviderRef<CollectionReference<Supplier>>;
String _$sDocumentRefHash() => r'bcbad21ca7d0db7943add40b935ca81cb940db16';

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

/// See also [sDocumentRef].
@ProviderFor(sDocumentRef)
const sDocumentRefProvider = SDocumentRefFamily();

/// See also [sDocumentRef].
class SDocumentRefFamily extends Family<DocumentReference<Supplier>> {
  /// See also [sDocumentRef].
  const SDocumentRefFamily();

  /// See also [sDocumentRef].
  SDocumentRefProvider call(
    String id,
  ) {
    return SDocumentRefProvider(
      id,
    );
  }

  @override
  SDocumentRefProvider getProviderOverride(
    covariant SDocumentRefProvider provider,
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
  String? get name => r'sDocumentRefProvider';
}

/// See also [sDocumentRef].
class SDocumentRefProvider
    extends AutoDisposeProvider<DocumentReference<Supplier>> {
  /// See also [sDocumentRef].
  SDocumentRefProvider(
    String id,
  ) : this._internal(
          (ref) => sDocumentRef(
            ref as SDocumentRefRef,
            id,
          ),
          from: sDocumentRefProvider,
          name: r'sDocumentRefProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sDocumentRefHash,
          dependencies: SDocumentRefFamily._dependencies,
          allTransitiveDependencies:
              SDocumentRefFamily._allTransitiveDependencies,
          id: id,
        );

  SDocumentRefProvider._internal(
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
    DocumentReference<Supplier> Function(SDocumentRefRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SDocumentRefProvider._internal(
        (ref) => create(ref as SDocumentRefRef),
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
  AutoDisposeProviderElement<DocumentReference<Supplier>> createElement() {
    return _SDocumentRefProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SDocumentRefProvider && other.id == id;
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
mixin SDocumentRefRef on AutoDisposeProviderRef<DocumentReference<Supplier>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _SDocumentRefProviderElement
    extends AutoDisposeProviderElement<DocumentReference<Supplier>>
    with SDocumentRefRef {
  _SDocumentRefProviderElement(super.provider);

  @override
  String get id => (origin as SDocumentRefProvider).id;
}

String _$supplierRepositoryHash() =>
    r'a96a0041f8ad6eca171744282dbadde488ca36a5';

/// See also [supplierRepository].
@ProviderFor(supplierRepository)
final supplierRepositoryProvider = Provider<SupplierRepository>.internal(
  supplierRepository,
  name: r'supplierRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$supplierRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SupplierRepositoryRef = ProviderRef<SupplierRepository>;
String _$suppliersHash() => r'08e6bc94235e19a681176bdcabaa5f9ce62551ac';

/// See also [suppliers].
@ProviderFor(suppliers)
final suppliersProvider = AutoDisposeStreamProvider<List<Supplier>>.internal(
  suppliers,
  name: r'suppliersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$suppliersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SuppliersRef = AutoDisposeStreamProviderRef<List<Supplier>>;
String _$supplierHash() => r'4cc643b2395c8537945a27a4f13e4f1dadc80a89';

/// See also [supplier].
@ProviderFor(supplier)
const supplierProvider = SupplierFamily();

/// See also [supplier].
class SupplierFamily extends Family<AsyncValue<Supplier>> {
  /// See also [supplier].
  const SupplierFamily();

  /// See also [supplier].
  SupplierProvider call(
    String id,
  ) {
    return SupplierProvider(
      id,
    );
  }

  @override
  SupplierProvider getProviderOverride(
    covariant SupplierProvider provider,
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
  String? get name => r'supplierProvider';
}

/// See also [supplier].
class SupplierProvider extends AutoDisposeStreamProvider<Supplier> {
  /// See also [supplier].
  SupplierProvider(
    String id,
  ) : this._internal(
          (ref) => supplier(
            ref as SupplierRef,
            id,
          ),
          from: supplierProvider,
          name: r'supplierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$supplierHash,
          dependencies: SupplierFamily._dependencies,
          allTransitiveDependencies: SupplierFamily._allTransitiveDependencies,
          id: id,
        );

  SupplierProvider._internal(
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
    Stream<Supplier> Function(SupplierRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SupplierProvider._internal(
        (ref) => create(ref as SupplierRef),
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
  AutoDisposeStreamProviderElement<Supplier> createElement() {
    return _SupplierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SupplierProvider && other.id == id;
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
mixin SupplierRef on AutoDisposeStreamProviderRef<Supplier> {
  /// The parameter `id` of this provider.
  String get id;
}

class _SupplierProviderElement
    extends AutoDisposeStreamProviderElement<Supplier> with SupplierRef {
  _SupplierProviderElement(super.provider);

  @override
  String get id => (origin as SupplierProvider).id;
}

String _$suppliersCollHash() => r'a14378d53f229417f06750c7c0be458303dcf99d';

/// See also [suppliersColl].
@ProviderFor(suppliersColl)
final suppliersCollProvider =
    AutoDisposeFutureProvider<List<Supplier>>.internal(
  suppliersColl,
  name: r'suppliersCollProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$suppliersCollHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SuppliersCollRef = AutoDisposeFutureProviderRef<List<Supplier>>;
String _$supplierDocHash() => r'a6b8896b2ddae6de4f70074c47c17c6a17a6546d';

/// See also [supplierDoc].
@ProviderFor(supplierDoc)
const supplierDocProvider = SupplierDocFamily();

/// See also [supplierDoc].
class SupplierDocFamily extends Family<AsyncValue<Supplier?>> {
  /// See also [supplierDoc].
  const SupplierDocFamily();

  /// See also [supplierDoc].
  SupplierDocProvider call(
    String id,
  ) {
    return SupplierDocProvider(
      id,
    );
  }

  @override
  SupplierDocProvider getProviderOverride(
    covariant SupplierDocProvider provider,
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
  String? get name => r'supplierDocProvider';
}

/// See also [supplierDoc].
class SupplierDocProvider extends AutoDisposeFutureProvider<Supplier?> {
  /// See also [supplierDoc].
  SupplierDocProvider(
    String id,
  ) : this._internal(
          (ref) => supplierDoc(
            ref as SupplierDocRef,
            id,
          ),
          from: supplierDocProvider,
          name: r'supplierDocProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$supplierDocHash,
          dependencies: SupplierDocFamily._dependencies,
          allTransitiveDependencies:
              SupplierDocFamily._allTransitiveDependencies,
          id: id,
        );

  SupplierDocProvider._internal(
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
    FutureOr<Supplier?> Function(SupplierDocRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SupplierDocProvider._internal(
        (ref) => create(ref as SupplierDocRef),
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
  AutoDisposeFutureProviderElement<Supplier?> createElement() {
    return _SupplierDocProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SupplierDocProvider && other.id == id;
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
mixin SupplierDocRef on AutoDisposeFutureProviderRef<Supplier?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _SupplierDocProviderElement
    extends AutoDisposeFutureProviderElement<Supplier?> with SupplierDocRef {
  _SupplierDocProviderElement(super.provider);

  @override
  String get id => (origin as SupplierDocProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
