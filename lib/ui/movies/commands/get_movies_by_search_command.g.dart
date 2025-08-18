// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_movies_by_search_command.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(GetMoviesBySearchCommand)
const getMoviesBySearchCommandProvider = GetMoviesBySearchCommandProvider._();

final class GetMoviesBySearchCommandProvider
    extends
        $NotifierProvider<GetMoviesBySearchCommand, AsyncValue<List<Movie>>> {
  const GetMoviesBySearchCommandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getMoviesBySearchCommandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getMoviesBySearchCommandHash();

  @$internal
  @override
  GetMoviesBySearchCommand create() => GetMoviesBySearchCommand();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Movie>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Movie>>>(value),
    );
  }
}

String _$getMoviesBySearchCommandHash() =>
    r'b43dae9dfd5e71ecc9bc2506727b8a8314f99460';

abstract class _$GetMoviesBySearchCommand
    extends $Notifier<AsyncValue<List<Movie>>> {
  AsyncValue<List<Movie>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<Movie>>, AsyncValue<List<Movie>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Movie>>, AsyncValue<List<Movie>>>,
              AsyncValue<List<Movie>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
