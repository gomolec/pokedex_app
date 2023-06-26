
# PokédexApp

Aplikacja PokédexApp jest demonstracją moich umiejętności programistycznych zdobytych podczas praktyk zawodowych, w szczególności znajomości zasad "Clean Architecture" oraz umiejętności integracji z zewnętrznym API - [POKEAPI](https://pokeapi.co/). Pozwala ona na przeglądanie listy Pokémonów, wyświetlanie szczegółowych informacji o nich oraz ich wyszukiwanie.


## Screenshots

|  |  |
|:---:|:---:|
| ![App Screenshot](readme_assets/screenshot1.png) | ![App Screenshot](readme_assets/screenshot2.png) |


## Features

- Wyświetlanie listy pokémonów z zastosowaniem paginacji, by ograniczyć ilość pobieranych danych 
- Po kliknięciu danego elementu zostajemy przeniesieni na ekran ze szczegółowymi informacjami
- Możliwość wyszukiwania pokémonów po ich nazwie lub miedzynarodowym identyfikatorze


## Tech Stack (packages)

 - **Pobieranie danych z API** - [Http](https://pub.dev/packages/http)
 - **State Management** - [Flutter Bloc](https://pub.dev/packages/flutter_bloc)
 - **Zapisywanie danych lokalnie** - [Hive](https://pub.dev/packages/hive)
 - Equatable, rxdart, dartz
