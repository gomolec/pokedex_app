import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:pokedex/features/pokedex/data/models/pokemon_model.dart';
import 'package:pokedex/features/pokedex/data/models/pokemons_result.dart';

import '../../../../core/error/exception.dart';

abstract class PokedexRemoteDataSource {
  // Calls the https://pokeapi.co/api/v2/pokemon?limit=10000 endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<PokemonsResult>> getPokemonList();

  // Calls the given url endpoint.
  ///
  /// Throws a [ServerException] for all error codes.books score
  Future<PokemonModel> getPokemonDetails({required String url});
}

class PokedexRemoteDataSourceImpl implements PokedexRemoteDataSource {
  final http.Client client;

  const PokedexRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<PokemonsResult>> getPokemonList() async {
    final responce = await client.get(
      Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=10000"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (responce.statusCode == 200) {
      final decodedJson = json.decode(responce.body);
      return decodedJson['results']
          .map<PokemonsResult>((e) => PokemonsResult.fromJson(e))
          .toList();
    }

    throw ServerException();
  }

  @override
  Future<PokemonModel> getPokemonDetails({required String url}) async {
    final responce = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (responce.statusCode == 200) {
      return PokemonModel.fromJson(json.decode(responce.body));
    }

    throw ServerException();
  }
}
