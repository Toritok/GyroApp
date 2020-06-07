import 'dart:async';

import 'package:esense_flutter/esense.dart';


final String eSenseName = 'eSense-0091';

class ESenseRepo {
  int currentAxis = 0;
  StreamSubscription subscription;


  Stream<ConnectionEvent> listenToConnect() async* {
    print("hiuer");
    await for (ConnectionEvent event in ESenseManager.connectionEvents) {
      print(event);
      yield event;
    }
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