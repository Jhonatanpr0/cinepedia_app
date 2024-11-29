import 'package:flutter/material.dart';

import 'package:cinepedia_app/presentation/widgets/widgets.dart';
import 'package:cinepedia_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullscreenLoader();

    final popularMovies = ref.watch(popularMoviesProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return Visibility(
      visible: !initialLoading,
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: CustomAppbar(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    //const CustomAppbar(),
                    MoviesSlideshow(movies: moviesSlideshow),
                    MoviesHorizontalListview(
                      movies: nowPlayingMovies,
                      title: 'En cines',
                      subTitle: 'Martes 19',
                      loadNextPage: () => ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage(),
                    ),
                    MoviesHorizontalListview(
                      movies: upcomingMovies,
                      title: 'Proximamente',
                      //subTitle: 'Martes 19',
                      loadNextPage: () => ref
                          .read(upcomingMoviesProvider.notifier)
                          .loadNextPage(),
                    ),
                    MoviesHorizontalListview(
                      title: 'Mas populares',
                      movies: popularMovies,
                      subTitle: 'Este mes',
                      loadNextPage: () =>
                          ref.read(popularMoviesProvider.notifier).loadNextPage(),
                    ),
                    MoviesHorizontalListview(
                      movies: topRatedMovies,
                      title: 'Mejor Calificadas',
                      subTitle: 'Este mes',
                      loadNextPage: () => ref
                          .read(topRatedMoviesProvider.notifier)
                          .loadNextPage(),
                    ),
      
                    const SizedBox(height: 10),
                  ],
                );
              },
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
