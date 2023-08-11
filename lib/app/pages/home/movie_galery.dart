import 'package:cinereview/app/components/movie_card.dart';
import 'package:cinereview/app/data/models/movie_model.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';

class MovieGalery extends StatelessWidget {
  final List<MovieModel> movies;
  final String title;

  const MovieGalery({super.key, required this.movies, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 180,
              child: Text(
                title,
                style: ProjectText.tittle,
              ),
            ),
          ],
        ),
        Container(height: 16),
        SizedBox(
          height: 258,
          child: ListView.separated(
              itemCount: movies.length,
              separatorBuilder: (context, index) {
                return Container(width: 16);
              },
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return MovieCard(movie: movies[index]);
              }),
        ),
      ],
    );
  }
}
