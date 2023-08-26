import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future get({required String url});
}

class HttpClient implements IHttpClient {
  final client = http.Client();
  final String hostname = 'https://api.themoviedb.org';
  final String _token = dotenv.env['API_TOKEN'] ?? '';

  @override
  Future get({required String url}) async {
    return await client.get(
      Uri.parse(hostname + url),
      headers: {'Authorization': 'Bearer $_token'},
    );
  }
}

class ApiUrls {
  static const String trendMovies = '/3/trending/movie/day?language=pt-BR';

  static const String moviesByGender =
      '/3/discover/movie?include_adult=false&include_video=false&language=pt-BR&page=1&sort_by=popularity.desc&with_genres=';
    
  String getIdUrl(String id) {
    return '/3/movie/$id?language=pt-BR';
  }

  String getQueryUrl(String query) {
    return '/3/search/movie?query=$query&include_adult=true&language=pt-BR&page=1';
  }
}
