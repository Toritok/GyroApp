import 'dart:async';

import 'package:esense_flutter/esense.dart';


final String eSenseName = 'eSense-0091';

class ESenseRepo {
  int currentAxis = 0;
  StreamSubscription subscription;


  Stream<ConnectionEvent> listenToConnect() async* {
    ESenseManager.connect(eSenseName);
    await for (ConnectionEvent event in ESenseManager.connectionEvents) {
      print(event);
      yield event;
    }
  }

  Stream<SensorEvent> listenToData() async* {
    ESenseManager.setSamplingRate(50);
      await for (SensorEvent event in ESenseManager.sensorEvents) {
        yield event;
      }
  }

  void pauseListenToSensorEvents() async {
    ESenseManager.disconnect();
  }

}