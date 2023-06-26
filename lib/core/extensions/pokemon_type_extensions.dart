import 'package:flutter/animation.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon.dart';

extension PokemonTypeExtensions on PokemonType {
  Color get color {
    switch (this) {
      case PokemonType.bug:
        return const Color(0xFFA7B723);
      case PokemonType.dark:
        return const Color(0xFF75574C);
      case PokemonType.dragon:
        return const Color(0xFF7037FF);
      case PokemonType.electric:
        return const Color(0xFFF9CD30);
      case PokemonType.fairy:
        return const Color(0xFFE69EAC);
      case PokemonType.fighting:
        return const Color(0xFFC12239);
      case PokemonType.fire:
        return const Color(0xFFF57D31);
      case PokemonType.flying:
        return const Color(0xFFA891EC);
      case PokemonType.ghost:
        return const Color(0xFF70559B);
      case PokemonType.normal:
        return const Color(0xFFAAA67F);
      case PokemonType.grass:
        return const Color(0xFF74CB48);
      case PokemonType.ground:
        return const Color(0xFFDEC16B);
      case PokemonType.ice:
        return const Color(0xFF9AD6DF);
      case PokemonType.poison:
        return const Color(0xFFA43E9E);
      case PokemonType.psychic:
        return const Color(0xFFFB5584);
      case PokemonType.rock:
        return const Color(0xFFB69E31);
      case PokemonType.steel:
        return const Color(0xFFB7B9D0);
      case PokemonType.water:
        return const Color(0xFF6493EB);
      default:
        return const Color(0xFFE0E0E0);
    }
  }
}
