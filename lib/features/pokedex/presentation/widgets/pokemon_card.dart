import 'package:flutter/material.dart';

import '../../../../core/extensions/pokemon_type_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../domain/entities/pokemon.dart';
import '../pages/pokemon_details_page.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PokemonDetailsPage(pokemon: pokemon),
      )),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: pokemon.types.first.color.withOpacity(0.24),
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        ),
        child: Column(
          children: [
            pokemon.imgUrl != null
                ? AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      pokemon.imgUrl!,
                    ),
                  )
                : const SizedBox.shrink(),
            const Spacer(),
            Text(
              pokemon.name.capitalize(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text("#${pokemon.id.toString().padLeft(3, "0")}"),
          ],
        ),
      ),
    );
  }
}
