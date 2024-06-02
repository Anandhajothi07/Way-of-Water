import 'dart:convert';
import 'package:http/http.dart' as http;

class AdafruitIOService {
  final String baseUrl = 'https://io.adafruit.com/api/v2/An7ndaj/feeds/rain/data';
  final String apiKey = 'aio_jXSQ68XWDvqLirysWAxkP7DuHXSz';

  Future<List<String>> fetchData() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'X-AIO-Key': apiKey},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((entry) => entry['value'].toString()).toList();
    } else {
      throw Exception('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }
}
