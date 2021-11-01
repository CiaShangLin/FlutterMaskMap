import 'package:flutter/services.dart';

abstract class IMaskDataService {
  Future<String> getMaskData();
}

class MaskDataService extends IMaskDataService {
  @override
  Future<String> getMaskData() {
    return rootBundle.loadString("assets/mask.json");
  }
}
