import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final String? userName;
  final String? location;
  final String? landArea;

  SettingsPage({this.userName, this.location, this.landArea});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController userNameController;
  late TextEditingController locationController;
  late TextEditingController landAreaController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.userName ?? '');
    locationController = TextEditingController(text: widget.location ?? '');
    landAreaController = TextEditingController(text: widget.landArea ?? '');
  }

  @override
  void dispose() {
    userNameController.dispose();
    locationController.dispose();
    landAreaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userNameController,
              decoration: InputDecoration(labelText: 'User Name'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: landAreaController,
              decoration: InputDecoration(labelText: 'Land Area'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
