import 'package:cinereview/app/data/models/movie_model.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';

class BiggerMovieCard extends StatefulWidget {
  static const posterHost = 'https://image.tmdb.org/t/p/w500';
  final MovieModel movie;

  const BiggerMovieCard({super.key, required this.movie});

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 10,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
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
