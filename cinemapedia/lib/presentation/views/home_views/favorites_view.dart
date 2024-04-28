import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// * init
// * only first 10

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();

    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoriteMoviesProvider).values.toList();

    if (favorites.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_outline_sharp,
                size: 60,
                color: colors.primary,
              ),
              Text(
                'Ohh no!',
                style: TextStyle(fontSize: 30, color: colors.primary),
              ),
              const Text(
                'You don\'t have favorite movies :(',
                style: TextStyle(fontSize: 20, color: Colors.black45),
              ),
              const SizedBox(height: 20),
              FilledButton.tonal(
                  onPressed: () => context.go('/'),
                  child: const Text('Start browsing!'))
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(
        loadNextPage: loadNextPage,
        movies: favorites,
      ),
    );
  }
}
