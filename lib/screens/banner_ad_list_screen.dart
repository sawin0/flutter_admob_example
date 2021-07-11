import 'package:flutter/material.dart';
import 'package:flutter_admob_example/ad_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class BannerAdListScreen extends StatefulWidget {
  @override
  _BannerAdListScreenState createState() => _BannerAdListScreenState();
}

class _BannerAdListScreenState extends State<BannerAdListScreen> {
  late List<ListTile> itemList;
  late List<Container> adWidgetList;

  @override
  void initState() {
    super.initState();
    itemList = List<ListTile>.generate(
        100, (int index) => ListTile(title: Text("Hello $index")));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        adWidgetList = List<Container>.generate(
          100,
          (index) => Container(
            height: 50.0,
            child: AdWidget(
                ad: BannerAd(
              size: AdSize.banner,
              adUnitId: adState.bannerAdUnitId,
              listener: BannerAdListener(
                onAdLoaded: (_) {
                  print('Ad loaded');
                },
                onAdFailedToLoad: (ad, err) {
                  print('Failed to load a banner ad: ${err.message}');
                  ad.dispose();
                },
              ),
              request: AdRequest(),
            )..load()),
          ),
        );
      });
    });
    print(itemList.runtimeType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Banner Ad With List'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: itemList.length,
        itemBuilder: (context, i) {
          if (i % 9 == 0 && i != 0) {
            return Column(
              children: [adWidgetList[i], itemList[i]],
            );
          }
          return itemList[i];
          // return itemList[i];
        },
      ),
    );
  }
}
