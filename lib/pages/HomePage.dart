 // ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'package:app/pages/SensorLayoutPage.dart';
import 'package:app/pages/StartPage.dart';
import 'package:app/pages/SettingsPage.dart';
import 'package:app/pages/weatherpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import "StartPage.dart";

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

  Future<http.Response> togglePump(bool newState) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pump/data'),
      headers: {
        'Content-Type': 'application/json',
        'X-AIO-Key': apiKey,
      },
      body: jsonEncode({'value': newState ? 'ON' : 'OFF'}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to toggle pump. Status code: ${response.statusCode}');
    }

    return response;
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AdafruitIOService adafruitIOService = AdafruitIOService();
  String rainData = 'Loading...';
  String moistureData = 'Loading...';
  bool pumpStatus = false;
  String waterLevelData = 'Loading...';
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    fetchDataAndRefresh();
    _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (mounted) {
        fetchDataAndRefresh();
      } else {
        timer.cancel();
      }
    });
  }

  void fetchDataAndRefresh() async {
    try {
      String rain = await adafruitIOService.fetchData('rain');
      String moisture = await adafruitIOService.fetchData('soil-moisture');
      String pump = await adafruitIOService.fetchData('pump');
      String waterLevel = await adafruitIOService.fetchData('water-level');

      if (mounted) {
        setState(() {
          rainData = rain;
          moistureData = moisture;
          pumpStatus = pump.toLowerCase() == 'on';
          waterLevelData = waterLevel;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> togglePump(bool newState) async {
    try {
      final response = await adafruitIOService.togglePump(newState);
      final updatedPumpStatus = jsonDecode(response.body)['value'];

      if (mounted) {
        setState(() {
          pumpStatus = updatedPumpStatus.toLowerCase() == 'on';
        });
      }

      print('Toggle Pump Successful. Updated Pump Status: $updatedPumpStatus');
    } catch (e) {
      print('Error toggling pump: $e');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Way Of Water',
        style :TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        )
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.cloud),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeatherPage()),
              );
            },
          ),
        ],
      ),
      drawer: buildAppDrawer(),
      body: ListView(
        children: [
          buildSquareGrid('Rain', rainData, 'assets/cloud.png'),
          buildSquareGrid('Moisture', moistureData, 'assets/waterdrop.png'),
          buildPumpGrid('Pump', pumpStatus),
          buildSquareGrid('Water Level', waterLevelData, 'assets/waterlevel.png'),
        ],
      ),
    );
  }

  Widget buildSquareGrid(String title, String data, String imagePath) {
    return Card(
      elevation: 5.0,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.1, // Adjust as needed
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                imagePath,
                height: 50.0,
                width: 50.0,
              ),
              SizedBox(height: 10.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                data,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPumpGrid(String title, bool pumpStatus) {
    return Card(
      elevation: 5.0,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8, // Adjust as needed
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Icon(
                pumpStatus ? Icons.power_settings_new : Icons.power_off,
                size: 50.0,
                color: pumpStatus ? Colors.green : Colors.red,
              ),
              SizedBox(height: 10.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0),
              Switch(
                value: pumpStatus,
                onChanged: (bool value) {
                  togglePump(value);
                },
                activeColor: Colors.green,
                inactiveThumbColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppDrawer() {
    return Drawer(
      child: Container(
        color: Colors.lightBlue,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.yellow,
              ),
              child: Center(
                child: Text(
                  'Way of Water',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            buildDrawerItem('Home', Icons.home),
            buildDrawerItem('Settings', Icons.settings),
            buildDrawerItem('Layout', Icons.grid_on),
            buildDrawerItem('Status of Sensors', Icons.info),

            Divider(),
            buildDrawerItem('Logout', Icons.exit_to_app),
          ],
        ),
      ),
    );
  }

  ListTile buildDrawerItem(String title, IconData icon) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      onTap: () {
        // Handle drawer item tap
        Navigator.pop(context); // Close the drawer
        if (title == "Settings"){
          Navigator.push(context,MaterialPageRoute(builder: (context) => SettingsPage()),);

        }
        if (title == "Home"){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
        if (title == "Layout"){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SensorLayoutPage()));
        }
        if (title == "Logout"){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StartPage()));
        }

        // Add navigation logic or actions based on the selected item
      },
    );
  }
}

class AdafruitDataPage extends StatelessWidget {
  final AdafruitIOService adafruitIOService = AdafruitIOService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adafruit Data'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder<String>(
              future: adafruitIOService.fetchData('rain'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text('Rain Data: ${snapshot.data}');
                }
              },
            ),
            // Similar FutureBuilder for other data (moisture, pump-status, water-level)
          ],
        ),
      ),
    );
  }
}