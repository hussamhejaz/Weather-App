import 'package:http/http.dart'as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({required this.url});

  final String? url;


  Future getData() async {
    http.Response response = await http.get(Uri.parse(url!));
    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);
      return decoded;
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  }
}
