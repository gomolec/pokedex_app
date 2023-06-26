import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/mappers/pokemon_mapper.dart';
import 'package:pokedex/features/pokedex/data/models/pokemon_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  test(
    "should return a valid model",
    () {
      final result =
          PokemonModel.fromJson(json.decode(fixture('single_pokemon.json')));

      // print(result.abilities[0]['ability']['name']);
      // print(result.types[0]['type']['name']);
      // print(result.statistics[0]["base_stat"]);
      // print(result.sprites['front_default']);
      // print(result.sprites['other']['dream_world']['front_default']);
      // print(result.sprites['other']['dream_world']['front_defau4lt']);

      print(PokemonMapper().map(result));
    },
  );
}
