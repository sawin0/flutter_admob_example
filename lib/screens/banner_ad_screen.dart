import 'package:flutter/material.dart';
import 'package:flutter_admob_example/ad_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class BannerAdScreen extends StatefulWidget {
  @override
  _BannerAdScreenState createState() => _BannerAdScreenState();
}

class _BannerAdScreenState extends State<BannerAdScreen> {
  late BannerAd bannerAd;

  bool _isBannerReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        bannerAd = BannerAd(
          size: AdSize.banner,
          adUnitId: adState.bannerAdUnitId,
          listener: BannerAdListener(
            onAdLoaded: (_) {
              setState(() {
                _isBannerReady = true;
              });
              print('Ad loaded');
            },
            onAdFailedToLoad: (ad, err) {
              print('Failed to load a banner ad: ${err.message}');
              ad.dispose();
            },
          ),
          request: AdRequest(),
        )..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Banner Ad'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blueAccent,
            ),
          ),
          if (_isBannerReady)
            Container(
              height: 50.0,
              child: AdWidget(
                ad: bannerAd,
              ),
            )
          else
            Container(
              height: 50.0,
              child: Center(child: Text('Loading Ad...')),
            )
        ],
      ),
    );
  }
}
