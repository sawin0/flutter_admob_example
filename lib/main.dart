import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'ad_state.dart';
import 'screens/about_screen.dart';
import 'screens/banner_ad_list_screen.dart';
import 'screens/banner_ad_screen.dart';
import 'screens/interstitial_ad_screen.dart';
import 'screens/rewarded_ad_screen.dart';

enum AdExample {
  banner,
  bannerAdList,
  interstitial,
  rewarded,
  about,
}

extension on AdExample {
  String capitalizeFirstCharacter() {
    final name = describeEnum(this);
    return name.replaceRange(0, 1, name.characters.first.toUpperCase());
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  runApp(Provider.value(
    value: adState,
    builder: (context, child) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter AdMob Example"),
        ),
        body: MyHomePage(),
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'banner':
            return MaterialPageRoute(builder: (_) => BannerAdScreen());
          case 'bannerAdList':
            return MaterialPageRoute(builder: (_) => BannerAdListScreen());
          case 'interstitial':
            return MaterialPageRoute(builder: (_) => InterstitialAdScreen());
          case 'rewarded':
            return MaterialPageRoute(builder: (_) => RewardedAdScreen());
          case 'about':
            return MaterialPageRoute(builder: (_) => AboutScreen());

          default:
            throw UnimplementedError('Route ${settings.name} not implemented');
        }
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final example = AdExample.values[index];
        final routeName = describeEnum(example);
        return ListTile(
          title: Text(example.capitalizeFirstCharacter()),
          trailing: Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).pushNamed(routeName),
        );
      },
      itemCount: AdExample.values.length,
    );
  }
}
