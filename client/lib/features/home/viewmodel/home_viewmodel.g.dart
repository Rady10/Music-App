// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAllSongsHash() => r'a06f06bef1b9213d7a6fb1458e5a4d32f0c45f7e';

/// See also [getAllSongs].
@ProviderFor(getAllSongs)
final getAllSongsProvider = AutoDisposeFutureProvider<List<SongModel>>.internal(
  getAllSongs,
  name: r'getAllSongsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getAllSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllSongsRef = AutoDisposeFutureProviderRef<List<SongModel>>;
String _$getGenreSongsHash() => r'f462413c8c4a969027b2d46ef280142a4184850c';

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

/// See also [getGenreSongs].
@ProviderFor(getGenreSongs)
const getGenreSongsProvider = GetGenreSongsFamily();

/// See also [getGenreSongs].
class GetGenreSongsFamily extends Family<AsyncValue<List<SongModel>>> {
  /// See also [getGenreSongs].
  const GetGenreSongsFamily();

  /// See also [getGenreSongs].
  GetGenreSongsProvider call(
    String genreName,
  ) {
    return GetGenreSongsProvider(
      genreName,
    );
  }

  @override
  GetGenreSongsProvider getProviderOverride(
    covariant GetGenreSongsProvider provider,
  ) {
    return call(
      provider.genreName,
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
  String? get name => r'getGenreSongsProvider';
}

/// See also [getGenreSongs].
class GetGenreSongsProvider extends AutoDisposeFutureProvider<List<SongModel>> {
  /// See also [getGenreSongs].
  GetGenreSongsProvider(
    String genreName,
  ) : this._internal(
          (ref) => getGenreSongs(
            ref as GetGenreSongsRef,
            genreName,
          ),
          from: getGenreSongsProvider,
          name: r'getGenreSongsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getGenreSongsHash,
          dependencies: GetGenreSongsFamily._dependencies,
          allTransitiveDependencies:
              GetGenreSongsFamily._allTransitiveDependencies,
          genreName: genreName,
        );

  GetGenreSongsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.genreName,
  }) : super.internal();

  final String genreName;

  @override
  Override overrideWith(
    FutureOr<List<SongModel>> Function(GetGenreSongsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetGenreSongsProvider._internal(
        (ref) => create(ref as GetGenreSongsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        genreName: genreName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<SongModel>> createElement() {
    return _GetGenreSongsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetGenreSongsProvider && other.genreName == genreName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, genreName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetGenreSongsRef on AutoDisposeFutureProviderRef<List<SongModel>> {
  /// The parameter `genreName` of this provider.
  String get genreName;
}

class _GetGenreSongsProviderElement
    extends AutoDisposeFutureProviderElement<List<SongModel>>
    with GetGenreSongsRef {
  _GetGenreSongsProviderElement(super.provider);

  @override
  String get genreName => (origin as GetGenreSongsProvider).genreName;
}

String _$getAllGenresHash() => r'6f10956a928cb08c521a4d7d61d399d5202a42fe';

/// See also [getAllGenres].
@ProviderFor(getAllGenres)
final getAllGenresProvider =
    AutoDisposeFutureProvider<List<GenreModel>>.internal(
  getAllGenres,
  name: r'getAllGenresProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getAllGenresHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllGenresRef = AutoDisposeFutureProviderRef<List<GenreModel>>;
String _$getFavoriteSongsHash() => r'3c956b3d3cd76b302e170043a9a8755e225e8c1e';

/// See also [getFavoriteSongs].
@ProviderFor(getFavoriteSongs)
final getFavoriteSongsProvider =
    AutoDisposeFutureProvider<List<SongModel>>.internal(
  getFavoriteSongs,
  name: r'getFavoriteSongsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getFavoriteSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetFavoriteSongsRef = AutoDisposeFutureProviderRef<List<SongModel>>;
String _$homeViewmodelHash() => r'f995a676c6fbd5065f0bc1e98d2ac6a8e590b9b7';

/// See also [HomeViewmodel].
@ProviderFor(HomeViewmodel)
final homeViewmodelProvider =
    AutoDisposeNotifierProvider<HomeViewmodel, AsyncValue?>.internal(
  HomeViewmodel.new,
  name: r'homeViewmodelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeViewmodelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeViewmodel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
