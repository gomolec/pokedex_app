import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/features/pokedex/domain/usecases/get_queried_pokemon_list.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:pokedex/features/pokedex/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokedex/domain/usecases/get_paginated_pokemon_list.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

const _postLimit = 20;
const _throttleDuration = Duration(milliseconds: 100);
const _debounceDuration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  PokedexBloc({
    required this.getPaginatedPokemonList,
    required this.httpClient,
    required this.getQueriedPokemonList,
  }) : super(const PokedexState()) {
    on<PokedexFetched>(
      _onPokedexFetched,
      transformer: throttleDroppable(_throttleDuration),
    );
    on<PokedexSearched>(
      _onPokedexSearched,
      transformer: debounce(_debounceDuration),
    );
  }

  final GetPaginatedPokemonList getPaginatedPokemonList;
  final GetQueriedPokemonList getQueriedPokemonList;
  final http.Client httpClient;

  List<Pokemon> fetchedPokemons = [];
  bool hasReachedMax = false;

  Future<void> _onPokedexFetched(
    PokedexFetched event,
    Emitter<PokedexState> emit,
  ) async {
    if (state.hasReachedMax) return;

    if (state.status == PokedexStatus.initial) {
      emit(state.copyWith(status: PokedexStatus.loading));
    }

    try {
      final pokemons = await getPaginatedPokemonList(
        GetPaginatedPokemonListParams(
          startIndex: fetchedPokemons.length,
          limit: _postLimit,
        ),
      );

      pokemons.fold(
        (failure) => throw Exception(),
        (pokemons) {
          if (pokemons.isEmpty) {
            hasReachedMax = true;
            emit(state.copyWith(hasReachedMax: hasReachedMax));
            return;
          }
          fetchedPokemons.addAll(pokemons);
          emit(state.copyWith(
            status: PokedexStatus.success,
            pokemons: List.of(fetchedPokemons),
            hasReachedMax: hasReachedMax,
          ));
        },
      );
    } catch (_) {
      emit(state.copyWith(status: PokedexStatus.failure));
    }
  }

  Future<void> _onPokedexSearched(
    PokedexSearched event,
    Emitter<PokedexState> emit,
  ) async {
    emit(state.copyWith(status: PokedexStatus.loading));

    if (event.query.isEmpty) {
      emit(state.copyWith(
        status: PokedexStatus.success,
        pokemons: List.of(fetchedPokemons),
        hasReachedMax: hasReachedMax,
      ));
      return;
    }

    try {
      final pokemons = await getQueriedPokemonList(
        GetQueriedPokemonListParams(
          limit: _postLimit,
          query: event.query,
        ),
      );

      pokemons.fold(
        (failure) => throw Exception(),
        (pokemons) {
          emit(state.copyWith(
            status: PokedexStatus.success,
            pokemons: pokemons,
            hasReachedMax: true,
          ));
        },
      );
    } catch (_) {
      emit(state.copyWith(status: PokedexStatus.failure));
    }
  }
}
