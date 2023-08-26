import 'package:cinereview/app/data/models/movie_model.dart';
import 'package:cinereview/app/data/repositories/users_repository.dart';
import 'package:cinereview/app/services/auth_service.dart';
import 'package:cinereview/app/styles/colors.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:provider/provider.dart';

class BiggerMovieCard extends StatefulWidget {
  static const posterHost = 'https://image.tmdb.org/t/p/w500';
  final MovieModel movie;
  final VoidCallback reloadFunction;
  final bool showFavButton;

  const BiggerMovieCard(
      {super.key,
      required this.movie,
      required this.showFavButton,
      required this.reloadFunction});

  @override
  State<BiggerMovieCard> createState() => _BiggerMovieCardState();
}

class _BiggerMovieCardState extends State<BiggerMovieCard> {
  getFormattedTittle() {
    if (widget.movie.title.length > 30) {
      return '${widget.movie.title.substring(0, 30)}...';
    }

    return widget.movie.title;
  }

  goToMovieDetails() {
    Navigator.pushNamed(
      context,
      '/movie/info',
      arguments: {'movie': widget.movie},
    );
  }

  toggleFavorite() async {
    await UsersRepository(
      auth: context.read<AuthService>(),
    ).toggleFavorites(widget.movie.id.toString());
    widget.reloadFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 10,
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              InkWell(
                splashColor: Colors.black.withAlpha(30),
                onTap: goToMovieDetails,
                child: SizedBox(
                  width: double.infinity,
                  height: 246,
                  child: widget.movie.posterPath != ''
                      ? Image.network(
                          BiggerMovieCard.posterHost + widget.movie.posterPath,
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Text('Poster não encontrado'),
                        ),
                ),
              ),
              Visibility(
                visible: widget.showFavButton,
                child: TextButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.transparent),
                    elevation: MaterialStatePropertyAll(0),
                  ),
                  onPressed: toggleFavorite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Stack(children: [
                          Icon(
                            PhosphorIcons.heart_fill,
                            color: ProjectColors.pink,
                            size: 44,
                            shadows: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          Icon(
                            PhosphorIcons.heart_light,
                            size: 44,
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 3), // Define a posição da sombra
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 8,
        ),
        SizedBox(
          width: 150,
          child: Text(
            widget.movie.title,
            style: ProjectText.biggerMovieCard,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
