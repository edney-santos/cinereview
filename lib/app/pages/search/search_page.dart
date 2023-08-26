import 'dart:async';

import 'package:cinereview/app/components/bigger_movie_card.dart';
import 'package:cinereview/app/components/custom_form_field.dart';
import 'package:cinereview/app/data/http/http_client.dart';
import 'package:cinereview/app/data/repositories/movies_repository.dart';
import 'package:cinereview/app/pages/search/store/search_movie_store.dart';
import 'package:cinereview/app/styles/colors.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchMovieStore store = SearchMovieStore(
    repository: MoviesRepository(
      client: HttpClient(),
    ),
  );

  final search = TextEditingController();
  Timer debounceTimer = Timer(const Duration(seconds: 30), () {});

  goBackHome() {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  onSearchChange() {
    debounceTimer.cancel();

    debounceTimer = Timer(const Duration(seconds: 1), () {
      store.searchMovies(search.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        return true;
      },
      child: Scaffold(
        backgroundColor: ProjectColors.background,
        body: Padding(
          padding: const EdgeInsets.only(left: 24, top: 64, right: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 80,
                    child: IconButton(
                      onPressed: goBackHome,
                      icon: const Icon(PhosphorIcons.arrow_left, size: 32),
                    ),
                  ),
                  Container(width: 12),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CustomFormField(
                        onChanged: (String a) {
                          onSearchChange();
                        },
                        autoFocus: true,
                        controller: search,
                        label: '',
                        color: ProjectColors.orange,
                        keyType: TextInputType.text,
                        obscureText: false,
                        placeholder: 'Pesquise pelo nome do filme',
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedBuilder(
                animation: Listenable.merge(
                  [store.isLoading, store.foundMovies, store.error],
                ),
                builder: (context, child) {
                  if (store.isLoading.value) {
                    return Column(
                      children: [
                        Container(height: 48),
                        const Center(
                          child: CircularProgressIndicator(
                            color: ProjectColors.orange,
                          ),
                        ),
                      ],
                    );
                  }

                  if (store.error.value.isNotEmpty) {
                    return Column(
                      children: [
                        Container(height: 24),
                        Center(
                          child: Text(
                            store.error.value,
                            style: ProjectText.bold,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  }

                  if (store.foundMovies.value.isEmpty) {
                    return Column(
                      children: [
                        Container(height: 24),
                        const Center(
                          child: Text(
                            'Nenhum filme encontrado',
                            style: ProjectText.bold,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Expanded(
                      child: GridView.builder(
                        itemCount: store.foundMovies.value.length,
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
                            movie: store.foundMovies.value[index],
                          );
                        },
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
