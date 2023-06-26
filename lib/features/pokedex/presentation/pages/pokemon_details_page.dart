import 'package:flutter/material.dart';

import '../../../../core/extensions/pokemon_type_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../domain/entities/pokemon.dart';
import '../widgets/widgets.dart';

class PokemonDetailsPage extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailsPage({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 24.0 + MediaQuery.of(context).padding.top,
            ),
            PokemonAppbar(
              title: pokemon.name.capitalize(),
              subtitle: "#${pokemon.id.toString().padLeft(3, "0")}",
            ),
            const SizedBox(
              height: 36.0,
            ),
            PokemonImage(
              imageUrl: pokemon.imgUrl,
              backgroundColor: pokemon.types[0].color.withOpacity(0.24),
            ),
            const SizedBox(height: 24.0),
            PokemonDetailsListView(pokemon: pokemon),
            const SizedBox(
              height: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
