import 'package:pokedex/core/extensions/string_extensions.dart';
import 'package:pokedex/core/utilities/unit_conversion.dart';
import 'package:pokedex/features/pokedex/domain/entities/pokemon.dart';

import '../../features/pokedex/data/models/pokemon_model.dart';
import 'package:collection/collection.dart';

class PokemonMapper {
  final List<String> statsKeys = [
    "HP",
    "Attack",
    "Defence",
    "Sp. Atk",
    "Sp. Def",
    "Speed",
  ];

  Pokemon map(PokemonModel model) {
    final List<PokemonType> types = model.types.map<PokemonType>((e) {
      return PokemonType.values.firstWhereOrNull(
              (element) => element.name == e['type']['name']) ??
          PokemonType.unknown;
    }).toList();

    Map<String, int> statistics = {};
    for (var i = 0; i < model.statistics.length; i++) {
      statistics.putIfAbsent(
          statsKeys[i], () => model.statistics[i]["base_stat"]);
    }

    statistics.putIfAbsent('Total', () => statistics.values.sum);

    double height = model.height / 10;
    double weight = model.weight / 10;

    String abilities = "";
    for (var i = 0; i < model.abilities.length; i++) {
      abilities += model.abilities[i]['ability']['name']
          .toString()
          .replaceAll('-', ' ')
          .capitalize();
      if (i != model.abilities.length - 1) {
        abilities += ", ";
      }
    }

    return Pokemon(
      id: model.id,
      name: model.name,
      height:
          "${height.toStringAsFixed(2)} m (${metersToFeetsAndInches(height)})",
      weight: "${weight.toStringAsFixed(2)} kg (${kilogramsToPounds(weight)})",
      abilities: abilities,
      types: types,
      stats: statistics,
      imgUrl: model.sprites['other']['official-artwork']['front_default'] ??
          model.sprites['front_default'],
    );
  }
}
