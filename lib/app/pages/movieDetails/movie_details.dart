import 'package:flutter/material.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late dynamic arguments;

  getInfo() {
    arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
  }

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text('Teste'));
  }
}
