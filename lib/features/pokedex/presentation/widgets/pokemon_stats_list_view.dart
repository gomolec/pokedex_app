import 'package:flutter/material.dart';

import '../../domain/entities/pokemon.dart';
import 'widgets.dart';

class StatsListView extends StatelessWidget {
  const StatsListView({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Base Stats",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8.0),
        Column(
          children: () {
            List<Widget> widgets = [];
            List<String> keys = pokemon.stats.keys.toList();
            for (var i = 0; i < pokemon.stats.length; i++) {
              int value = pokemon.stats[keys[i]] ?? 1;
              double percentage =
                  keys[i] != "Total" ? value / 100 : value / 600;
              widgets.add(
                StatsListTile(
                  title: keys[i],
                  value: value.toString(),
                  percentage: percentage,
                ),
              );
              if (i != pokemon.stats.length - 1) {
                widgets.add(const SizedBox(
                  height: 8.0,
                ));
              }
            }
            return widgets;
          }(),
        ),
      ],
    );
  }
}
