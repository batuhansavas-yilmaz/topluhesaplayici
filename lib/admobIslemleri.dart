import 'package:firebase_admob/firebase_admob.dart';

class AdmobIslemleri {
  static final String AppIdCanli = "ca-app-pub-9520376060064699~6369844951";
  static final String AppIdTest = FirebaseAdMob.testAppId;
static final String bannerCanli ="ca-app-pub-9520376060064699/8218290850";
  static admobInitialize() {
    FirebaseAdMob.instance.initialize(appId: AppIdCanli);
  }

  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>[
      'flutter',
      'invoice',
      'tax',
      'tools',
      'solver',
      'aquarium',
      'fish'
    ],
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  static BannerAd buildBannerAd(){
    return BannerAd(
    //adUnitId: bannerCanli,
     adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
  }
}
