import 'package:cinereview/app/components/nav_bar.dart';
import 'package:cinereview/app/components/review_card.dart';
import 'package:cinereview/app/data/repositories/reviews_repository.dart';
import 'package:cinereview/app/pages/reviews/store/reviews_store.dart';
import 'package:cinereview/app/services/auth_service.dart';
import 'package:cinereview/app/styles/colors.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:provider/provider.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  late ReviewsStore store;

  @override
  @override
  void initState() {
    super.initState();

    store = ReviewsStore(
      ReviewsRepository(
        auth: Provider.of<AuthService>(context, listen: false),
      ),
    );

    store.getReviews();
  }

  navigateBack() {
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.background,
      body: AnimatedBuilder(
          animation: Listenable.merge(
            [store.isLoading, store.userReviews, store.error],
          ),
          builder: (context, child) {
            if (store.isLoading.value) {
              return const Scaffold(
                backgroundColor: ProjectColors.background,
                body: Center(
                  child: CircularProgressIndicator(
                    color: ProjectColors.orange,
                  ),
                ),
              );
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

            if (store.userReviews.value.isEmpty) {
              return const Center(
                child: Text(
                  'Você ainda não adicionou reviews',
                  style: ProjectText.bold,
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 64, left: 24, right: 24),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: navigateBack,
                            icon: const Icon(
                              PhosphorIcons.arrow_left,
                              size: 32,
                            ),
                          ),
                          Container(width: 12),
                          const Text('Meus reviews', style: ProjectText.tittle),
                        ],
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 20),
                        shrinkWrap: true,
                        itemCount: store.userReviews.value.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ReviewCard(
                                review: store.userReviews.value[index],
                                showMovieTitle: true,
                              ),
                              Container(height: 16)
                            ],
                          );
                        },
                      ),
                      Container(height: 32)
                    ],
                  ),
                ),
              );
            }
          }),
      bottomNavigationBar: NavBar(context, 2),
    );
  }
}
