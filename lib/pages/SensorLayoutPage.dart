import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'HomePage.dart';

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

class SensorLayoutPage extends StatefulWidget {
  @override
  _SensorLayoutPageState createState() => _SensorLayoutPageState();
}

class _SensorLayoutPageState extends State<SensorLayoutPage> {
  final AdafruitIOService adafruitIOService = AdafruitIOService();
  String locationData = 'Loading...';
  String latitudeData = '';
  String longitudeData = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSensorData();
  }

  Future<void> fetchSensorData() async {
    try {
      final location = await adafruitIOService.fetchData('location');
      final latitude = await adafruitIOService.fetchData('latitude');
      final longitude = await adafruitIOService.fetchData('longitude');

      setState(() {
        locationData = location;
        latitudeData = latitude;
        longitudeData = longitude;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching sensor data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sensor Layout',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.blue,
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
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.0),
                    Center(
                      child: Icon(
                        Icons.location_on,
                        size: 50.0,
                        color: Colors.purple,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: Text(
                        'Sensor Location',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        children: List.generate(8, (index) {
                          return Card(
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sensor ${index + 1}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  index == 0
                                      ? Column(
                                          children: [
                                            Text(
                                              'Location: $locationData',
                                              style: TextStyle(fontSize: 14.0),
                                            ),
                                            SizedBox(height: 5.0),
                                            Text(
                                              'Latitude: $latitudeData',
                                              style: TextStyle(fontSize: 14.0),
                                            ),
                                            SizedBox(height: 5.0),
                                            Text(
                                              'Longitude: $longitudeData',
                                              style: TextStyle(fontSize: 14.0),
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
