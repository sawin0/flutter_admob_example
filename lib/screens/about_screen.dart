import 'package:flutter/material.dart';
import 'package:flutter_admob_example/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  static const _url = 'https://github.com/sawin0/flutter_admob_example';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('This is just demo of AdMob using Flutter')),
          Center(
            child: ElevatedButton(
              onPressed: _launchGithub,
              child: Text('View Code'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: _openMarket,
              child: Text('Rate App'),
            ),
          ),
        ],
      ),
    );
  }

  void _launchGithub() => launch(_url);

  void _openMarket() => launch(APP_URL);
}
