import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/core/error/failures.dart';
import 'package:pokedex/features/pokedex/domain/repositories/pokedex_repository.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon.dart';

class GetPaginatedPokemonList
    implements UseCase<List<Pokemon>, GetPaginatedPokemonListParams> {
  final PokedexRepository repository;

  const GetPaginatedPokemonList(
    this.repository,
  );

  @override
  Future<Either<Failure, List<Pokemon>>> call(
      GetPaginatedPokemonListParams params) async {
    return await repository.getPaginatedPokemonList(
      startIndex: params.startIndex,
      limit: params.limit,
    );
  }
}

class GetPaginatedPokemonListParams extends Equatable {
  final int startIndex;
  final int limit;

  const GetPaginatedPokemonListParams({
    required this.startIndex,
    required this.limit,
  });

  @override
  List<Object> get props => [startIndex, limit];
}
