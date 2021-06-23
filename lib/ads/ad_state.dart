import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  AdState._internal();

  static AdState _instance = AdState._internal();

  static AdState get instance => _instance;

  Future<void> init() async {
    initializations = MobileAds.instance.initialize();
  }

  Future<InitializationStatus>? initializations;

  String get bannerAdUntil {
    if (!kReleaseMode) {
      return BannerAd.testAdUnitId;
    }

    if (kIsWeb) {
      return "";
    }

    if (Platform.isAndroid) {
      return dotenv.env['BannerAndroid'].toString();
    }

    return "";
  }

  BannerAdListener get adListener => _adListener;

  BannerAdListener _adListener = BannerAdListener(
    onAdLoaded: (Ad ad) => print('Ad loaded'),
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      print('Ad failed to load $error');
    },
    onAdOpened: (Ad ad) => print('Ad opened'),
    onAdClosed: (Ad ad) => print('Ad closed'),
  );
}
