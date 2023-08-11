import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    final dynamic arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final genre = arguments['genre'].toString();
    // final genreId = arguments['genreId'].toString();

    return Scaffold(
      body: Column(
        children: [
          Text(
            genre,
            style: ProjectText.tittle,
          ),
        ],
      ),
    );
  }
}
