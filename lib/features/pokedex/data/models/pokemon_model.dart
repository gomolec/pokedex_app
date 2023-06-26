import 'package:equatable/equatable.dart';

class PokemonModel extends Equatable {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List abilities;
  final List types;
  final List statistics;
  final Map<String, dynamic> sprites;

  const PokemonModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.types,
    required this.statistics,
    required this.sprites,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> map) {
    return PokemonModel(
      id: map['id'].toInt(),
      name: map['name'],
      height: map['height'].toInt(),
      weight: map['weight'].toInt(),
      abilities: map['abilities'],
      types: map['types'],
      statistics: map['stats'],
      sprites: map['sprites'],
    );
  }

  @override
  String toString() {
    return 'PokemonModel(id: $id, name: $name, height: $height, weight: $weight, abilities: $abilities, types: $types, statistics: $statistics, sprites: $sprites)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      height,
      weight,
      abilities,
      types,
      statistics,
      sprites,
    ];
  }
}
