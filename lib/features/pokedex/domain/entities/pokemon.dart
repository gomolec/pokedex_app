import 'package:equatable/equatable.dart';

enum PokemonType {
  normal,
  fighting,
  flying,
  poison,
  ground,
  rock,
  bug,
  ghost,
  steel,
  fire,
  water,
  grass,
  electric,
  psychic,
  ice,
  dragon,
  dark,
  fairy,
  unknown,
  shadow
}

class Pokemon extends Equatable {
  final int id;
  final String name;
  final String height;
  final String weight;
  final String abilities;
  final List<PokemonType> types;
  final Map<String, int> stats;
  final String? imgUrl;

  const Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.types,
    required this.stats,
    required this.imgUrl,
  });

  @override
  String toString() {
    return 'Pokemon(id: $id, name: $name, height: $height, weight: $weight, abilities: $abilities, types: $types, stats: $stats, imgUrl: $imgUrl)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      height,
      weight,
      abilities,
      types,
      stats,
      imgUrl,
    ];
  }
}
