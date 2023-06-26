import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pokedex_bloc.dart';
import 'pokemon_card.dart';

class PokemonGrid extends StatelessWidget {
  const PokemonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokedexBloc, PokedexState>(
      builder: (context, state) {
        switch (state.status) {
          case PokedexStatus.failure:
            return const Center(child: Text('Failed to load pokemons'));
          case PokedexStatus.loading:
            return const LoadingIndicator();
          case PokedexStatus.initial:
            return const LoadingIndicator();
          case PokedexStatus.success:
            if (state.pokemons.isEmpty) {
              return const Center(child: Text('No pokemons found'));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 8 / 11,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return PokemonCard(pokemon: state.pokemons[index]);
                    },
                    itemCount: state.pokemons.length,
                  ),
                  !state.hasReachedMax
                      ? const BottomLoader()
                      : const SizedBox.shrink(),
                ],
              ),
            );
        }
      },
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 96.0),
        child: CircularProgressIndicator(
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text("More pokemons are loading..."),
        ),
      ),
    );
  }
}
