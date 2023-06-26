import 'package:pokedex/features/pokedex/data/models/pokemons_result.dart';

class PokemonSearchService {
  List<PokemonsResult> search({
    required List<PokemonsResult> data,
    required String query,
  }) {
    return data.where((element) {
      return (element.name).contains(query) ||
          int.tryParse(query) == element.id;
    }).toList();
  }
}
