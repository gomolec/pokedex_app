import 'package:dartz/dartz.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon.dart';

abstract class PokedexRepository {
  Future<Either<Failure, List<Pokemon>>> getPaginatedPokemonList({
    required int startIndex,
    required int limit,
  });

  Future<Either<Failure, List<Pokemon>>> getQueriedPokemonList({
    required int limit,
    required String query,
  });
}
