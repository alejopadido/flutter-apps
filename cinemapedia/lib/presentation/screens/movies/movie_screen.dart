import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppbar(movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(movie: movie),
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(width: 10),

              //* Movie Description
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyles.titleLarge),
                    Text(movie.overview),
                  ],
                ),
              )
            ],
          ),
        ),

        //* Movie Genres
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map(
                (genre) => Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(genre),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
            ],
          ),
        ),

        _ActorsByMovie(movieId: movie.id),

        const SizedBox(height: 10),
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final int movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId.toString()] == null) {
      return const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    final actors = actorsByMovie[movieId.toString()];

    return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: actors!.length,
          itemBuilder: (context, index) {
            final actor = actors[index];

            return Container(
              padding: const EdgeInsets.all(8),
              width: 135,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* Actor Photo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),

                  //* Actor Name
                  const SizedBox(height: 5),
                  Text(actor.name, maxLines: 2),
                  Text(
                    actor.character ?? '',
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}

final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return localStorageRepository
      .isMovieFavorite(movieId); // If it's in favorites
});

class _CustomSliverAppbar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppbar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      actions: [
        IconButton(
            onPressed: () async {
              // ref.read(localStorageRepositoryProvider).toggleFavorite(movie);
              await ref
                  .read(favoriteMoviesProvider.notifier)
                  .toggleFavorite(movie);

              ref.invalidate(isFavoriteProvider(movie.id));
            },
            icon: isFavoriteFuture.when(
              data: (isFavorite) => isFavorite
                  ? const Icon(Icons.favorite_rounded, color: Colors.red)
                  : const Icon(Icons.favorite_border),
              error: (_, __) => throw UnimplementedError(),
              loading: () => const Icon(Icons.refresh_outlined),
            )
            // const Icon(Icons.favorite_border),
            // icon: const Icon(Icons.favorite_rounded, color: Colors.red),
            )
      ],
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(fontSize: 20),
        //   textAlign: TextAlign.start,
        // ),
        titlePadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),
            const _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.2],
              colors: [
                Colors.black54,
                Colors.transparent,
              ],
            ),
            const _CustomGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.7, 1.0],
              colors: [
                Colors.transparent,
                Colors.black54,
              ],
            ),
            const _CustomGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.2],
              colors: [
                Colors.black54,
                Colors.transparent,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient({
    required this.begin,
    required this.end,
    required this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}
