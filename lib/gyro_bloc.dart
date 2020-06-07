import 'dart:async';
import 'package:esense_flutter/esense.dart';
import 'package:flutter/cupertino.dart';
import 'package:gyroapp/gyro_event.dart';
import 'package:gyroapp/gyro_repo.dart';
import 'package:gyroapp/gyro_state.dart';
import 'package:bloc/bloc.dart';




class EarableBloc extends Bloc<EarableEvent, EarableState> {
  final int _value = 0;
  final ESenseRepo _earable;


  StreamSubscription<int> axisSubscription;

  EarableBloc({@required ESenseRepo earable})
      : assert(earable != null),
        _earable = earable;

  @override
  EarableState get initialState => Launched(_value);

  @override
  void onTransition(Transition<EarableEvent, EarableState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<EarableState> mapEventToState(
      EarableEvent event,
      ) async* {
    if (event is Start) {
      yield* _mapStartToState(event);
    } else if (event is Stop) {
      yield* _mapPauseToState(event);
    }else if (event is Reset) {
      yield* _mapResetToState(event);
    }else if(event is Opened) {
      yield* _mapLaunchedToState(event);
    }
  }


  @override
  Future<void> close() {
    axisSubscription?.cancel();
    return super.close();
  }

  Stream<EarableState> _mapLaunchedToState(Opened open) async* {
    await for(ConnectionEvent event in _earable.listenToConnect()) {
      if(event.type == ConnectionType.connected) {
        yield Ready(_value);
      }
    }
  }

  Stream<EarableState> _mapStartToState(Start start) async* {
    print("hier");
    axisSubscription?.cancel();
      yield Running(_value);
    }

  Stream<EarableState> _mapPauseToState(Stop stop) async* {
    axisSubscription?.cancel();
    if (state is Running) {
      _earable.pauseListenToSensorEvents();
        yield Ready(_value);
    }
  }

  Stream<EarableState> _mapResetToState(Reset reset) async* {
    axisSubscription?.cancel();
    yield Running(_value);
  }
}
