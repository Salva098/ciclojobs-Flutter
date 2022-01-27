import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthHttpClient extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    final token = dotenv.env['ID_ALUMNO']??"";
    if (token.isNotEmpty) {
      final bearer= "Bearer "+token;
      request.headers.putIfAbsent('Authorization', () => bearer);
    }

    return request.send();

  }
  
}