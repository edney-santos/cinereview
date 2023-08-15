import 'package:cinereview/app/data/genres_list.dart';
import 'package:cinereview/app/data/models/movie_model.dart';
import 'package:cinereview/app/styles/colors.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:intl/intl.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  static const posterHost = 'https://image.tmdb.org/t/p/w500';
  late MovieModel movie;

  String formatNumber(int num) {
    final formater = NumberFormat('#,##0', 'pt_BR');
    return formater.format(num);
  }

  getGendersName(List<int> ids) {
    if (ids.isEmpty) {
      return '';
    }

    if (ids.length == 1) {
      dynamic find = GenresList.menuItens.firstWhere(
        (genre) => genre.id == ids[0],
      );
      return find.name;
    }

    String genderNames = '';

    for (int i = 0; i <= 1; i++) {
      dynamic find = GenresList.menuItens.firstWhere(
        (genre) => genre.id == ids[i],
      );

      if (find.runtimeType == Genre) {
        if (genderNames != '') {
          genderNames += find.name;
        } else {
          genderNames += '${find.name}, ';
        }
      }
    }

    return genderNames;
  }

  goToHome() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    dynamic arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, MovieModel>;
    movie = arguments['movie'];
    String formatedVotes = formatNumber(movie.voteCount);
    return Scaffold(
      backgroundColor: ProjectColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, top: 64, right: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(PhosphorIcons.arrow_left, size: 32),
                    onPressed: goToHome,
                  ),
                  const Icon(PhosphorIcons.heart, size: 32),
                ],
              ),
              SizedBox(
                width: 200,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 6,
                        blurRadius: 10,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(posterHost + movie.posterPath),
                  ),
                ),
              ),
              Container(height: 16),
              Text(
                movie.title,
                style: ProjectText.tittle,
                textAlign: TextAlign.center,
              ),
              Container(height: 24),
              Text(
                getGendersName(movie.genreIds),
                style: ProjectText.bold20,
              ),
              Container(height: 16),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        PhosphorIcons.star_fill,
                        size: 32,
                        color: Colors.amber[600],
                      ),
                      Container(width: 8),
                      Text(
                        movie.voteEverage.toString().substring(0, 3),
                        style: ProjectText.tittle,
                      ),
                    ],
                  ),
                  Text(
                    '$formatedVotes votos',
                    style: ProjectText.disabled,
                  )
                ],
              ),
              Container(height: 24),
              const Row(
                children: [
                  Text('Sinopse', style: ProjectText.tittle),
                ],
              ),
              Container(height: 16),
              Text(movie.overview, style: ProjectText.regular),
              Container(height: 16),
              const Row(
                children: [
                  Text('Reviews', style: ProjectText.tittle),
                ],
              ),
              Container(height: 48)
            ],
          ),
        ),
      ),
    );
  }
}
