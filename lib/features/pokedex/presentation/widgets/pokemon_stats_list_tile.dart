import 'package:flutter/material.dart';

class StatsListTile extends StatelessWidget {
  final String title;
  final String value;
  final double percentage;

  const StatsListTile({
    Key? key,
    required this.title,
    required this.value,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            child: LinearProgressIndicator(
              minHeight: 6.0,
              color: percentage < 0.5
                  ? const Color(0xFF72B38B)
                  : const Color(0xFFDC7373),
              backgroundColor: const Color(0xFFEBF3F5),
              value: percentage,
            ),
          ),
        ),
      ],
    );
  }
}
