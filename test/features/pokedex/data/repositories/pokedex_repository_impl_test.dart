import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/mappers/pokemon_mapper.dart';
import 'package:pokedex/core/services/pokemon_search_service.dart';
import 'package:pokedex/features/pokedex/data/datasources/pokedex_remote_data_source.dart';
import 'package:pokedex/features/pokedex/data/repositories/pokedex_repository_impl.dart';

class MockPokedexRemoteDataSource extends Mock
    implements PokedexRemoteDataSource {}

class MockPokemonMapper extends Mock implements PokemonMapper {}

class MockPokemonSearchService extends Mock implements PokemonSearchService {}

void main() {
  late PokedexRepositoryImpl repository;
  late MockPokedexRemoteDataSource mockDataSource;
  late MockPokemonMapper mockMapper;
  late MockPokemonSearchService mockSearchService;

  setUp(() {
    mockDataSource = MockPokedexRemoteDataSource();
    mockMapper = MockPokemonMapper();
    mockSearchService = MockPokemonSearchService();
    repository = PokedexRepositoryImpl(
      remoteDataSource: mockDataSource,
      pokemonMapper: mockMapper,
      pokemonSearchService: mockSearchService,
    );
  });

  group(
    "getPaginatedPokemonList",
    () {
      // const t
      // test(
      //   "should return remote data when the call to remote data source is successful",
      //   () {
      //     when(() => mockDataSource.getPokemonList()).thenAnswer((_) => )
      //   },
      // );
    },
  );
}
