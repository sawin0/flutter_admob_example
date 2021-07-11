import 'package:flutter/material.dart';
import 'package:flutter_admob_example/ad_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class InterstitialAdScreen extends StatefulWidget {
  @override
  _InterstitialAdScreenState createState() => _InterstitialAdScreenState();
}

class _InterstitialAdScreenState extends State<InterstitialAdScreen> {
  late InterstitialAd _interstitialAd;

  bool _isInterstitialAdReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        InterstitialAd.load(
          adUnitId: adState.interstitialAdUnitId,
          request: AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) {
              this._interstitialAd = ad;

              ad.fullScreenContentCallback = FullScreenContentCallback();

              _isInterstitialAdReady = true;
            },
            onAdFailedToLoad: (err) {
              print('Failed to load an interstitial ad: ${err.message}');
              _isInterstitialAdReady = false;
            },
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interstitial Ad'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_isInterstitialAdReady) {
                  _interstitialAd.show();
                } else {
                  _showMyDialog();
                }
              },
              child: Text('Show Ad'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ad Loading...'),
          content: Text('Please wait for a while.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _interstitialAd.dispose();
    super.dispose();
  }
}
