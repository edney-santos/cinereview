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
    List<int> getIds() {
      if (map['genre_ids'] == null) {
        List<int> genres = [];
        for (int i = 0; i < map['genres'].length; i++) {
          genres.add(map['genres'][i]['id']);
        }
        return genres;
      }
      return List<int>.from(map['genre_ids'] as List);
    }

    return MovieModel(
      map['id'],
      map['title'],
      map['overview'],
      map['poster_path'] ?? '',
      getIds(),
      map['vote_average'] * 1.0,
      map['vote_count'],
    );
  }
}
