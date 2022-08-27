import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:flutter_applovin_max/flutter_applovin_max.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
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
