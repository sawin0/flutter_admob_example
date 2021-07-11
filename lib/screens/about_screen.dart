import 'package:flutter/material.dart';
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
          )
        ],
      ),
    );
  }

  void _launchGithub() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  void openMarket() {
    launch(APP_URL);
  }
}
