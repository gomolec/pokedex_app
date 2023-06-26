import 'package:dartz/dartz.dart';

import 'package:pokedex/core/mappers/pokemon_mapper.dart';
import 'package:pokedex/core/services/pokemon_search_service.dart';
import 'package:pokedex/features/pokedex/data/datasources/pokedex_remote_data_source.dart';
import 'package:pokedex/features/pokedex/data/models/pokemons_result.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/repositories/pokedex_repository.dart';

class PokedexRepositoryImpl implements PokedexRepository {
  final PokedexRemoteDataSource remoteDataSource;
  final PokemonMapper pokemonMapper;
  final PokemonSearchService pokemonSearchService;

  PokedexRepositoryImpl({
    required this.remoteDataSource,
    required this.pokemonMapper,
    required this.pokemonSearchService,
  });

  List<PokemonsResult>? _cachedPokemonList;

  @override
  Future<Either<Failure, List<Pokemon>>> getPaginatedPokemonList({
    required int startIndex,
    required int limit,
  }) async {
    try {
      _cachedPokemonList ??= await remoteDataSource.getPokemonList();

      List<Pokemon> pokemons = [];

      int range = limit;

      if (_cachedPokemonList!.length - startIndex < limit) {
        range = _cachedPokemonList!.length - startIndex;
      }

      for (var i = 0; i < range; i++) {
        final pokemonModel = await remoteDataSource.getPokemonDetails(
            url: _cachedPokemonList![startIndex + i].url);
        pokemons.add(pokemonMapper.map(pokemonModel));
      }

      return Right(pokemons);
    } on ServerException {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Pokemon>>> getQueriedPokemonList({
    required int limit,
    required String query,
  }) async {
    try {
      final List<PokemonsResult> searchResults = pokemonSearchService.search(
        data: _cachedPokemonList!,
        query: query,
      );

      List<Pokemon> pokemons = [];

      int range = limit;

      if (searchResults.length < limit) {
        range = searchResults.length;
      }

      for (var i = 0; i < range; i++) {
        final pokemonModel =
            await remoteDataSource.getPokemonDetails(url: searchResults[i].url);
        pokemons.add(pokemonMapper.map(pokemonModel));
      }

      return Right(pokemons);
    } on ServerException {
      return const Left(ServerFailure());
    }
  }
}
