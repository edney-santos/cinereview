import 'package:cinereview/app/data/genres_list.dart';
import 'package:cinereview/app/styles/colors.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final Genre genre;

  const CategoryButton({
    super.key,
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: Colors.white,
          width: 1.0,
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/category',
              arguments: {'genre': genre.name, 'genreId': genre.id.toString()});
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ProjectColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 12,
            left: 24,
            right: 24,
          ),
          child: Text(
            genre.name,
            style: ProjectText.bold,
          ),
        ),
      ),
    );
  }
}
