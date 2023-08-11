import 'package:cinereview/app/data/models/movie_model.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';

class BiggerMovieCard extends StatelessWidget {
  static const posterHost = 'https://image.tmdb.org/t/p/w500';
  final MovieModel movie;

  const BiggerMovieCard({super.key, required this.movie});

  getFormattedTittle() {
    if (movie.title.length > 30) {
      return '${movie.title.substring(0, 30)}...';
    }

    return movie.title;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 10,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            splashColor: Colors.black.withAlpha(30),
            onTap: () {},
            child: SizedBox(
              width: double.infinity,
              height: 246,
              child: Image.network(posterHost + movie.posterPath),
            ),
          ),
        ),
        Container(
          height: 8,
        ),
        SizedBox(
          width: 150,
          child: Text(
            movie.title,
            style: ProjectText.biggerMovieCard,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
