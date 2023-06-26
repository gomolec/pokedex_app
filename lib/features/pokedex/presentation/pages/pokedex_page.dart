import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/pokedex_bloc.dart';
import '../widgets/widgets.dart';

class PokedexPage extends StatelessWidget {
  const PokedexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => sl<PokedexBloc>()..add(PokedexFetched()),
        child: const PokedexPageView(),
      ),
    );
  }
}

class PokedexPageView extends StatefulWidget {
  const PokedexPageView({
    Key? key,
  }) : super(key: key);

  @override
  State<PokedexPageView> createState() => _PokedexPageViewState();
}

class _PokedexPageViewState extends State<PokedexPageView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top + 32.0,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              "Pokédex",
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              "Search for a Pokémon by name or using its  National Pokédex number.",
              softWrap: true,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          const SearchBar(),
          const SizedBox(height: 0.0),
          const PokemonGrid()
        ],
      ),
    );
  }

  void _onScroll() {
    if (_isBottom) context.read<PokedexBloc>().add(PokedexFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
