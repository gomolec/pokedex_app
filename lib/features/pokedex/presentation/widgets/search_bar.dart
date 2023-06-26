import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pokedex_bloc.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  void _clearTextField() {
    setState(() {
      _controller.clear();
    });
    context.read<PokedexBloc>().add(const PokedexSearched(query: ''));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: TextField(
        onChanged: (value) {
          setState(() {});
          context.read<PokedexBloc>().add(PokedexSearched(query: value));
        },
        controller: _controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFEBF3F5),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: const Icon(Icons.search_rounded),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          labelText: 'Search',
          contentPadding: const EdgeInsets.all(8.0),
          suffixIcon: _controller.text.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.clear_rounded),
                  onPressed: _clearTextField,
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
