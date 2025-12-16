import 'package:flutter/foundation.dart';

abstract class AdService {
  void init();
}

class MobileAdService implements AdService {
  @override
  void init() {
    // тут буде GoogleMobileAds.instance.initialize();
  }
}

class WebAdService implements AdService {
  @override
  void init() {
    // нічого не робимо
  }
}

AdService getAdService() {
  if (kIsWeb) {
    return WebAdService();
  }
  return MobileAdService();
}
