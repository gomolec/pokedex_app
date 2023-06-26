import 'package:equatable/equatable.dart';

class PokemonsResult extends Equatable {
  final String name;
  final String url;
  final int id;

  const PokemonsResult({
    required this.name,
    required this.url,
    required this.id,
  });

  factory PokemonsResult.fromJson(Map<String, dynamic> map) {
    List<String> splittedUrl = map['url'].toString().split('/')..removeLast();
    return PokemonsResult(
      name: map['name'],
      url: map['url'],
      id: int.tryParse(splittedUrl.last) ?? -1,
    );
  }

  @override
  String toString() => 'PokemonsResult(name: $name, url: $url, id: $id)';

  @override
  List<Object> get props => [
        name,
        url,
        id,
      ];
}
