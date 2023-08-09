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
}
