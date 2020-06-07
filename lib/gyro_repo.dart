import 'dart:async';

import 'package:esense_flutter/esense.dart';
import 'package:gyroapp/gyro_event.dart';


final String eSenseName = 'eSense-0091';

class ESenseRepo {
  int currentAxis = 0;
  StreamSubscription subscription;
  bool sampling = false;
  int _offset;
  String _button;
  String _deviceStatus;

  Stream<ConnectionEvent> connectToESense() async* {

    // if you want to get the connection events when connecting, set up the listener BEFORE connecting...
    yield* ESenseManager.connectionEvents;

    await ESenseManager.connect(eSenseName);
  }

  Stream<ESenseEvent> listenToESenseEvents() async* {
    yield* ESenseManager.eSenseEvents;

    _getESenseOffset();
  }

  void _getESenseOffset() async {
    Timer(Duration(seconds: 3), () async => await ESenseManager.getAccelerometerOffset());
  }

  void startListenToSensorEvents() async {
    // subscribe to sensor event from the eSense device
    subscription = ESenseManager.sensorEvents.listen((event) {
      print('SENSOR event: $event');
    });
      sampling = true;
  }

  void pauseListenToSensorEvents() async {
    subscription.cancel();
      sampling = false;
  }

}