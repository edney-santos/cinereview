import 'package:cinereview/app/data/models/review_model.dart';
import 'package:cinereview/app/styles/colors.dart';
import 'package:cinereview/app/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;
  final bool showMovieTitle;

  const ReviewCard(
      {super.key, required this.review, this.showMovieTitle = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 4),
            Visibility(
              visible: showMovieTitle,
              child: Flexible(
                child: Text(
                  review.movieTitle,
                  style: ProjectText.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        Container(height: 8),
        FractionallySizedBox(
          widthFactor: 0.98,
          child: IntrinsicHeight(
            child: Container(
              decoration: BoxDecoration(
                color: ProjectColors.gray,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          review.reviewerName,
                          style: ProjectText.bold,
                        ),
                        const Spacer(),
                        Icon(
                          PhosphorIcons.star_fill,
                          size: 20,
                          color: Colors.amber[600],
                        ),
                        Container(width: 4),
                        Text(
                          review.rating.toStringAsFixed(2),
                          style: ProjectText.bold20,
                        )
                      ],
                    ),
                    Container(height: 16),
                    Container(
                      decoration: BoxDecoration(
                          color: ProjectColors.darkGray,
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          textAlign: TextAlign.left,
                          review.review,
                          style: ProjectText.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
