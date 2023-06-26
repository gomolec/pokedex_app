import 'package:flutter/material.dart';

class PokemonImage extends StatelessWidget {
  const PokemonImage({
    Key? key,
    required this.imageUrl,
    required this.backgroundColor,
  }) : super(key: key);

  final String? imageUrl;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 32.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 48.0,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: imageUrl != null
            ? Image.network(
                imageUrl!,
                fit: BoxFit.fitWidth,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey.shade300,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              )
            : const Center(
                child: Text("No image data"),
              ),
      ),
    );
  }
}
