import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class ConnectivityController extends GetxController {
  var connectionType = "".obs;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription streamSubscription;

  @override
  void onInit() {
    super.onInit();

    getConnectivityStatus();

    streamSubscription =
        connectivity.onConnectivityChanged.listen(getConnectivityType); 
  }

  Future<void> getConnectivityStatus() async {
    var connectivityResult;

    try {
      connectivityResult = await connectivity.checkConnectivity();
      getConnectivityType(connectivityResult);
    } catch (e) {
      Get.snackbar("exception", "Error during connectivity checking");
    }
  }

  void getConnectivityType(connectivityResult) {
    if (connectivityResult == ConnectivityResult.wifi) {
      connectionType.value = "Wifi";
    } else if (connectivityResult == ConnectivityResult.mobile) {
      connectionType.value = "Mobile internet";
    } else {
      connectionType.value = "no internet";
    }
  }
}
