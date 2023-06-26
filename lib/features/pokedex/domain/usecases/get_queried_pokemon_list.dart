import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/features/pokedex/domain/repositories/pokedex_repository.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon.dart';

class GetQueriedPokemonList
    implements UseCase<List<Pokemon>, GetQueriedPokemonListParams> {
  final PokedexRepository repository;

  const GetQueriedPokemonList(
    this.repository,
  );

  @override
  Future<Either<Failure, List<Pokemon>>> call(
      GetQueriedPokemonListParams params) async {
    return await repository.getQueriedPokemonList(
      limit: params.limit,
      query: params.query,
    );
  }
}

class GetQueriedPokemonListParams extends Equatable {
  final int limit;
  final String query;

  const GetQueriedPokemonListParams({
    required this.limit,
    required this.query,
  });

  @override
  List<Object> get props => [limit, query];
}
