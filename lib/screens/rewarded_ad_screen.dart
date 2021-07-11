import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../ad_state.dart';

class RewardedAdScreen extends StatefulWidget {
  @override
  _RewardedAdScreenState createState() => _RewardedAdScreenState();
}

class _RewardedAdScreenState extends State<RewardedAdScreen> {
  late RewardedAd _rewardedAd;

  bool _isRewardedAdReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        RewardedAd.load(
          adUnitId: adState.rewardedAdUnitId,
          request: AdRequest(),
          rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (ad) {
              this._rewardedAd = ad;

              ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  setState(() {
                    _isRewardedAdReady = false;
                  });
                },
              );

              setState(() {
                _isRewardedAdReady = true;
              });
            },
            onAdFailedToLoad: (err) {
              print('Failed to load a rewarded ad: ${err.message}');
              setState(() {
                _isRewardedAdReady = false;
              });
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
        title: Text('Rewarded Ad'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_isRewardedAdReady) {
                  _rewardedAd.show(
                      onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
                    print('User earned');
                  });
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
    _rewardedAd.dispose();
    super.dispose();
  }
}
