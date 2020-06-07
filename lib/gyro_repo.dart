import 'dart:async';

import 'package:esense_flutter/esense.dart';


final String eSenseName = 'eSense-0091';

class ESenseRepo {
  int currentAxis = 0;
  StreamSubscription subscription;


  void listenToConnect({Function(String) callback}) {
    ESenseManager.connectionEvents.listen((event) {
      print(event);
      if(event.type == ConnectionType.connected) {
        callback(event.toString());
      }
    });
  }

  void listenToData({Function(String) callback}) {
    subscription = ESenseManager.sensorEvents.listen((event) {
      callback(event.toString());
    });
  }

  void pauseListenToSensorEvents() async {
    subscription.cancel();
  }

}