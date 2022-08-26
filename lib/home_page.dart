import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_applovin_max/flutter_applovin_max.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return WebView(
      initialUrl: "https://manhuascan.us",
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}

class AppLovinAds extends StatefulWidget {
  const AppLovinAds({Key? key}) : super(key: key);

  @override
  State<AppLovinAds> createState() => _AppLovinAdsState();
}

class _AppLovinAdsState extends State<AppLovinAds> {
  bool isInterstitialVideoAvailable = false;
  bool isRewardedVideoAvailable = false;

  @override
  void initState() {
    super.initState();
    FlutterApplovinMax.initRewardAd('d8ec28af779f894f');
    FlutterApplovinMax.initInterstitialAd('eb71ced9891aaf40');
  }

  void listener(AppLovinAdListener event) {
    print(event);
    if (event == AppLovinAdListener.onUserRewarded) {
      print('👍get reward');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  isInterstitialVideoAvailable =
                      (await FlutterApplovinMax.isInterstitialLoaded(
                          (listener) => null))!;

                  if (isInterstitialVideoAvailable) {
                    FlutterApplovinMax.showInterstitialVideo(
                        (AppLovinAdListener? event) => listener(event!));
                  }
                },
                child: const Text('')),
            ElevatedButton(
                onPressed: () async {
                  isRewardedVideoAvailable =
                      (await FlutterApplovinMax.isRewardLoaded(
                          (listener) => null))!;

                  if (isRewardedVideoAvailable) {
                    FlutterApplovinMax.showRewardVideo(
                        (AppLovinAdListener? event) => listener(event!));
                  }
                },
                child: const Text(''))
          ],
        ),
      ),
    );
  }
}
