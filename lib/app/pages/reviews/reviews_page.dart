import 'package:cinereview/app/components/nav_bar.dart';
import 'package:cinereview/app/styles/colors.dart';
import 'package:flutter/material.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.background,
      body: const Column(
        children: [
          Center(
            child: Text('Reviews'),
          )
        ],
      ),
      bottomNavigationBar: NavBar(context, 2),
    );
  }
}
