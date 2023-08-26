import 'package:cinereview/app/components/bigger_movie_card.dart';
import 'package:cinereview/app/data/http/http_client.dart';
import 'package:cinereview/app/data/repositories/movies_repository.dart';
import 'package:cinereview/app/pages/category/stores/movies_catergory_store.dart';
import 'package:cinereview/app/styles/colors.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final MoviesCategoryStore store = MoviesCategoryStore(
    repository: MoviesRepository(
      client: HttpClient(),
    ),
  );

  navigateBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final dynamic arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final genre = arguments['genre'].toString();
    store.getByGender(arguments['genreId'].toString());

    return Scaffold(
      body: AnimatedBuilder(
          animation: Listenable.merge(
            [store.isLoading, store.moviesByGender, store.error],
          ),
          builder: (context, child) {
            if (store.isLoading.value) {
              return const Scaffold(
                backgroundColor: ProjectColors.background,
                body: Center(
                  child: CircularProgressIndicator(
                    color: ProjectColors.orange,
                  ),
                ),
              );
            }

            if (store.error.value.isNotEmpty) {
              return Center(
                child: Text(
                  store.error.value,
                  style: ProjectText.bold,
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (store.moviesByGender.value.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum item na lista.',
                  style: ProjectText.bold,
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Scaffold(
                backgroundColor: ProjectColors.background,
                body: Padding(
                  padding: const EdgeInsets.only(top: 64, left: 24, right: 24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: navigateBack,
                            icon: const Icon(
                              PhosphorIcons.arrow_left,
                              size: 32,
                            ),
                          ),
                          Container(width: 12),
                          Text(genre, style: ProjectText.tittle),
                        ],
                      ),
                      Expanded(
                        child: GridView.builder(
                          itemCount: store.moviesByGender.value.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 20,
                            crossAxisCount: 2,
                            childAspectRatio: 160 / 320,
                          ),
                          itemBuilder: (context, index) {
                            return BiggerMovieCard(
                              reloadFunction: () {},
                              showFavButton: false,
                              movie: store.moviesByGender.value[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
