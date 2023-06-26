part of 'pokedex_bloc.dart';

enum PokedexStatus { initial, loading, success, failure }

class PokedexState extends Equatable {
  const PokedexState({
    this.status = PokedexStatus.initial,
    this.pokemons = const <Pokemon>[],
    this.hasReachedMax = false,
  });

  final PokedexStatus status;
  final List<Pokemon> pokemons;
  final bool hasReachedMax;

  PokedexState copyWith({
    PokedexStatus? status,
    List<Pokemon>? pokemons,
    bool? hasReachedMax,
  }) {
    return PokedexState(
      status: status ?? this.status,
      pokemons: pokemons ?? this.pokemons,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PokedexState { status: $status, hasReachedMax: $hasReachedMax, posts: ${pokemons.length} }''';
  }

  @override
  List<Object> get props => [status, pokemons, hasReachedMax];
}
