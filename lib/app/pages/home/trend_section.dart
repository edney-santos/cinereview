import 'package:cinereview/app/components/movie_card.dart';
import 'package:cinereview/app/data/models/movie_model.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';

class TrendSection extends StatelessWidget {
  final List<MovieModel> movies;

  const TrendSection({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Text(
              'Populares',
              style: ProjectText.tittle,
            ),
          ],
        ),
        Container(height: 16),
        SizedBox(
          height: 300,
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
