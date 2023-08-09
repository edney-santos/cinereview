import 'package:cinereview/app/components/nav_bar.dart';
import 'package:cinereview/app/data/http/http_client.dart';
import 'package:cinereview/app/data/repositories/movies_repository.dart';
import 'package:cinereview/app/pages/home/stores/movies_store.dart';
import 'package:cinereview/app/pages/home/trend_section.dart';
import 'package:cinereview/app/services/auth_service.dart';
import 'package:cinereview/app/styles/colors.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MoviesStore store = MoviesStore(
    repository: MoviesRepository(
      client: HttpClient(),
    ),
  );

  logout() async {
    await context.read<AuthService>().logout();
  }

  @override
  void initState() {
    super.initState();
    store.getTrendMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.background,
      body: AnimatedBuilder(
        animation: Listenable.merge(
          [store.isLoading, store.error, store.trendMovies],
        ),
        builder: (context, child) {
          if (store.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (store.error.value.isNotEmpty) {
            return Center(
              child: Text(
                store.error.value,
                style: ProjectText.bold,
                textAlign: TextAlign.center,
              ),
            );
          }

          if (store.trendMovies.value.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum item na lista.',
                style: ProjectText.bold,
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 100, left: 24, right: 24),
                child: Column(
                  children: [
                    TrendSection(movies: store.trendMovies.value),
                  ],
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: NavBar(context, 0),
    );
  }
}
