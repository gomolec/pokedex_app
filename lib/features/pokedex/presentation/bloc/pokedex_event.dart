part of 'pokedex_bloc.dart';

abstract class PokedexEvent extends Equatable {
  const PokedexEvent();

  @override
  List<Object> get props => [];
}

class PokedexFetched extends PokedexEvent {}

class PokedexSearched extends PokedexEvent {
  final String query;

  const PokedexSearched({
    required this.query,
  });

  @override
  List<Object> get props => [query];
}
