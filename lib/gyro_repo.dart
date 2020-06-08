import 'dart:async';

import 'package:esense_flutter/esense.dart';


final String eSenseName = 'eSense-0091';

class ESenseRepo {
  int currentAxis = 0;
  StreamSubscription connectionSubscription;
  StreamSubscription eventSubscription;

  void listenToConnect({Function(ConnectionEvent) callback}) {
    ESenseManager.setSamplingRate(5);
    ESenseManager.connect(eSenseName);
    connectionSubscription = ESenseManager.connectionEvents.listen((event) {
      print(event);
      callback(event);
    });
  }

  void listenToData({Function(SensorEvent) callback}) {

    eventSubscription = ESenseManager.sensorEvents.listen((event) {
      print(event);
      callback(event);
    });

  }


  void dispose() {
    connectionSubscription.cancel();
    eventSubscription.cancel();
    ESenseManager.disconnect();
  }



}