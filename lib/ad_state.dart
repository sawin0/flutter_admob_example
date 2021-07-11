import 'dart:io';

import 'package:flutter_admob_example/constants/ad_units_constants.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  String get appOpenAdUnitId =>
      Platform.isAndroid ? appOpenAndroid : appOpeniOS;

  String get bannerAdUnitId => Platform.isAndroid ? bannerAndroid : banneriOS;

  String get interstitialAdUnitId =>
      Platform.isAndroid ? interstitialAndroid : interstitialiOS;

  String get interstitialVideoAdUnitId =>
      Platform.isAndroid ? interstitialVideoAndroid : interstitialVideoiOS;

  String get rewardedAdUnitId =>
      Platform.isAndroid ? rewardedAndroid : rewardediOS;

  String get rewardedInterstitialAdUnitId => Platform.isAndroid
      ? rewardedInterstitialAndroid
      : rewardedInterstitialiOS;
}
