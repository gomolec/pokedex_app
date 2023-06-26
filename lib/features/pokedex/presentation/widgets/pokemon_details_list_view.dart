import 'package:flutter/material.dart';

import '../../domain/entities/pokemon.dart';
import 'widgets.dart';

class PokemonDetailsListView extends StatelessWidget {
  const PokemonDetailsListView({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                flex: 2,
                child: Text(
                  "Types",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: TypeChips(types: pokemon.types),
              ),
            ],
          ),
          const Divider(
            height: 32.0,
          ),
          DetailsListTile(
            title: "Height",
            text: pokemon.height,
          ),
          const SizedBox(height: 16.0),
          DetailsListTile(
            title: "Weight",
            text: pokemon.weight,
          ),
          const SizedBox(height: 16.0),
          DetailsListTile(
            title: "Abilites",
            text: pokemon.abilities,
          ),
          const Divider(
            height: 32.0,
          ),
          StatsListView(pokemon: pokemon)
          //StatsListTile()
        ],
      ),
    );
  }
}
