import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  int _selectedLanguageIndex = 0;

  List<String> _languages = ['English', 'French', 'Spanish', 'German'];

  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });
  }

  void _changeLanguage(int? index) {
    setState(() {
      _selectedLanguageIndex = index ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Notifications'),
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: _toggleNotifications,
            ),
          ),
          ListTile(
            title: Text('Language'),
            trailing: DropdownButton(
              value: _selectedLanguageIndex,
              items: _languages.map((language) {
                return DropdownMenuItem(
                  child: Text(language),
                  value: _languages.indexOf(language),
                );
              }).toList(),
              onChanged: _changeLanguage,
            ),
          ),
        ],
      ),
    );
  }
}
