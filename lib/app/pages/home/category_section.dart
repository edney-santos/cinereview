import 'package:cinereview/app/components/category_button.dart';
import 'package:cinereview/app/data/genres_list.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [Text('Categorias', style: ProjectText.tittle)],
        ),
        Container(height: 16),
        SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CategoryButton(
                genre: GenresList.menuItens[index],
              );
            },
            separatorBuilder: (context, index) {
              return Container(width: 16);
            },
            itemCount: GenresList.menuItens.length,
          ),
        ),
      ],
    );
  }
}
