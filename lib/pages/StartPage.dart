import 'package:app/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/SettingsPage.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController landAreaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userNameController,
              decoration: InputDecoration(labelText: 'Enter User Name'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Enter Location'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: landAreaController,
              decoration: InputDecoration(labelText: 'Enter Land Area'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(
                      userName: userNameController.text,
                      location: locationController.text,
                      landArea: landAreaController.text,
                    ),
                  ),
                  
                );
              },
              child: Text(''),
            ),
             SizedBox(height: 20.0),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),));}, child: Text("Start App"),),
            )
          ],
        ),
      ),
    );
  }
}
