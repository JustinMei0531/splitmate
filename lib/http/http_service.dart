import "dart:convert";
import "dart:async";
import "package:http/http.dart" as http;

class HttpService {
  // Define GET and POST request individually
  HttpService();

  // POST request
  Future<http.Response> postRequest(
      String URL, Map<String, dynamic> body) async {
    try {
      http.Response response = await http.post(Uri.parse(URL),
          headers: {"Content-type": "application/json"},
          body: jsonEncode(body));
      return response;
    } catch (e) {
      throw Exception("Failed to send POST request to server: $e");
    }
  }

  // GET request with Authorization Bearer token
  Future<http.Response> getRequest(String URL, String token) async {
    try {
      http.Response response = await http.get(
        Uri.parse(URL),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (e) {
      throw Exception("Failed to send GET request to server: $e");
    }
  }
}
