class ReviewModel {
  final int movieId;
  final String reviewerId;
  final double rating;
  final String movieTitle;
  final String reviewerName;
  final String review;
  final String timestamp;

  ReviewModel(
    this.movieId,
    this.reviewerId,
    this.rating,
    this.movieTitle,
    this.reviewerName,
    this.review,
    this.timestamp,
  );

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      map['movieId'],
      map['reviewerId'],
      map['rating'],
      map['movieTitle'],
      map['reviewerName'],
      map['review'],
      map['timestamp'],
    );
  }
}
