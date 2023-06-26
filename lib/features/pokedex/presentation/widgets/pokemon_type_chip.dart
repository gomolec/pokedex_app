import 'package:flutter/material.dart';

import '../../../../core/extensions/pokemon_type_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../domain/entities/pokemon.dart';

class TypeChips extends StatelessWidget {
  final List<PokemonType> types;

  const TypeChips({
    Key? key,
    required this.types,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: types
          .map((type) => Container(
                decoration: BoxDecoration(
                    color: type.color.withOpacity(0.24),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(12.0))),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 4.0,
                ),
                margin: const EdgeInsets.only(right: 8.0),
                child: Text(
                  type.name.capitalize(),
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ))
          .toList(),
    );
  }
}
