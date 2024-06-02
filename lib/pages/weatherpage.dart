import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app/pages/HomePage.dart';

class AdafruitIOService {
  final String baseUrl = 'https://io.adafruit.com/An7ndaj/feeds';
  final String apiKey = 'aio_jXSQ68XWDvqLirysWAxkP7DuHXSz';

  Future<String> fetchData(String feedName) async {
    final response = await http.get(
      Uri.parse('$baseUrl$feedName/data'),
      headers: {'X-AIO-Key': apiKey},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return data.last['value'].toString();
      } else {
        return 'No data available';
      }
    } else {
      throw Exception('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final AdafruitIOService adafruitIOService = AdafruitIOService();
  List<String> _weatherLabels = ['Temperature', 'Rain', 'preassure', 'windSpeed', 'location'];
  List<String> _weatherData = ['Loading...', 'Loading...', 'Loading...', 'Loading...', 'Loading...'];

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    try {
      for (int i = 0; i < _weatherLabels.length; i++) {
        final data = await adafruitIOService.fetchData(_weatherLabels[i].toLowerCase());
        setState(() {
          _weatherData[i] = data;
        });
      }
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        backgroundColor: Colors.blue, // Set app bar color here
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _weatherLabels.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue.shade400, Colors.white],
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getWeatherIcon(_weatherLabels[index]),
                      size: 100,
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    Text(
                      _weatherLabels[index],
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    Text(
                      _weatherData[index],
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getWeatherIcon(String label) {
    switch (label.toLowerCase()) {
      case 'temperature':
        return Icons.thermostat;
      case 'rain':
        return Icons.water_drop;
      case 'preassure':
        return Icons.compress;
      case 'windspeed':
        return Icons.air;
      case 'location':
        return Icons.location_on;
      default:
        return Icons.help;
    }
  }
}
