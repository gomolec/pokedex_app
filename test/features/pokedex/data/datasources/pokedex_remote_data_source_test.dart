import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/mappers/pokemon_mapper.dart';
import 'package:pokedex/core/services/pokemon_search_service.dart';
import 'package:pokedex/features/pokedex/data/datasources/pokedex_remote_data_source.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/features/pokedex/data/repositories/pokedex_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late PokedexRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = PokedexRemoteDataSourceImpl(client: mockHttpClient);
  });

  group(
    "getPokemonList",
    () {
      test(
        "",
        () async {
          when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
              .thenAnswer(
            (_) async => http.Response(fixture("pokemon_list.json"), 200),
          );

          final result = await dataSource.getPokemonList();

          print(result);
        },
      );
    },
  );

  group(
    "getPokemonDetails",
    () {
      test(
        "",
        () async {
          final url = "https://pokeapi.co/api/v2/pokemon/1/";

          when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
              .thenAnswer(
            (_) async => http.Response(fixture("single_pokemon.json"), 200),
          );

          final result = await dataSource.getPokemonDetails(url: url);

          print(result);
        },
      );
    },
  );

  group(
    "repo test",
    () {
      test(
        "getPaginatedPokemonList",
        () async {
          final repository = PokedexRepositoryImpl(
            remoteDataSource: dataSource,
            pokemonMapper: PokemonMapper(),
            pokemonSearchService: PokemonSearchService(),
          );

          when(() => mockHttpClient.get(
              Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=10000"),
              headers: any(named: 'headers'))).thenAnswer(
            (_) async => http.Response(fixture("pokemon_list.json"), 200),
          );

          // when(() => mockHttpClient.get(
          //     Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=10000"),
          //     headers: any(named: 'headers'))).thenThrow(ServerException());

          when(() => mockHttpClient.get(
              Uri.parse("https://pokeapi.co/api/v2/pokemon/1/"),
              headers: any(named: 'headers'))).thenAnswer(
            (_) async => http.Response(fixture("single_pokemon.json"), 200),
          );

          when(() => mockHttpClient.get(
              Uri.parse("https://pokeapi.co/api/v2/pokemon/2/"),
              headers: any(named: 'headers'))).thenAnswer(
            (_) async => http.Response(fixture("single_pokemon.json"), 200),
          );

          when(() => mockHttpClient.get(
              Uri.parse("https://pokeapi.co/api/v2/pokemon/3/"),
              headers: any(named: 'headers'))).thenAnswer(
            (_) async => http.Response(fixture("single_pokemon.json"), 200),
          );

          final result =
              await repository.getPaginatedPokemonList(startIndex: 0, limit: 2);

          print(result);
        },
      );
    },
  );
}
