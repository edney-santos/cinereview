class MovieModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final List<int> genreIds;
  final double voteEverage;
  final int voteCount;

  MovieModel(
    this.id,
    this.title,
    this.overview,
    this.posterPath,
    this.genreIds,
    this.voteEverage,
    this.voteCount,
  );

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      map['id'],
      map['title'],
      map['overview'],
      map['poster_path'] ?? '',
      List<int>.from(map['genre_ids'] as List),
      map['vote_average'] * 1.0,
      map['vote_count'],
    );
  }
}
