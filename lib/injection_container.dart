import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/mappers/pokemon_mapper.dart';
import 'core/services/pokemon_search_service.dart';
import 'features/pokedex/data/datasources/pokedex_remote_data_source.dart';
import 'features/pokedex/data/repositories/pokedex_repository_impl.dart';
import 'features/pokedex/domain/repositories/pokedex_repository.dart';
import 'features/pokedex/domain/usecases/get_paginated_pokemon_list.dart';
import 'features/pokedex/domain/usecases/get_queried_pokemon_list.dart';
import 'features/pokedex/presentation/bloc/pokedex_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Pokedex
  // Bloc
  sl.registerFactory(
    () => PokedexBloc(
      getPaginatedPokemonList: sl(),
      getQueriedPokemonList: sl(),
      httpClient: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPaginatedPokemonList(sl()));
  sl.registerLazySingleton(() => GetQueriedPokemonList(sl()));

  // Repository
  sl.registerLazySingleton<PokedexRepository>(() => PokedexRepositoryImpl(
        remoteDataSource: sl(),
        pokemonMapper: sl(),
        pokemonSearchService: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<PokedexRemoteDataSource>(
    () => PokedexRemoteDataSourceImpl(client: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => PokemonMapper());
  sl.registerLazySingleton(() => PokemonSearchService());

  //!External
  sl.registerLazySingleton(() => http.Client());
}
