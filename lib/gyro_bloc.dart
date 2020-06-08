import 'dart:async';
import 'dart:math';
import 'package:esense_flutter/esense.dart';
import 'package:flutter/cupertino.dart';
import 'package:gyroapp/gyro_event.dart';
import 'package:gyroapp/gyro_repo.dart';
import 'package:gyroapp/gyro_state.dart';
import 'package:bloc/bloc.dart';




class EarableBloc extends Bloc<EarableEvent, EarableState> {
  int _value = 0;
  int _normedAngle;
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
    }else if(event is Connected) {
      yield* _mapConnectionToState(event);
    }else if(event is AxisUpdate) {
      yield* _mapAxisUpdateToState(event);
    }else if(event is ButtonUpdate) {

    }
  }


  @override
  Future<void> close() {
    axisSubscription?.cancel();
    return super.close();
  }

  Stream<EarableState> _mapConnectionToState(Connected connect) async* {
    axisSubscription?.cancel();
    yield Ready(_value);
  }
  Stream<EarableState> _mapAxisUpdateToState(AxisUpdate update) async* {
    axisSubscription?.cancel();
    yield Running(_value);
  }

  Stream<EarableState> _mapLaunchedToState(Opened open) async* {
    _earable.listenToConnect(callback: (ConnectionEvent event) {
         if(event.type == ConnectionType.connected) {
         this.add(Connected());
         }
    });
  }

  Stream<EarableState> _mapStartToState(Start start) async* {
    _earable.listenToData(callback: (SensorEvent event) {
        _calcAxis(event.accel[0], event.accel[1], event.accel[2]);
        add(AxisUpdate());
    });
  }

  Stream<EarableState> _mapPauseToState(Stop stop) async* {
    axisSubscription?.cancel();
    if (state is Running) {
      _earable.dispose();
      _value = 0;
        yield Launched(0);
    }
  }

  Stream<EarableState> _mapResetToState(Reset reset) async* {
    axisSubscription?.cancel();
    _normedAngle = null;
    yield Running(_value);
  }


  void _calcAxis(XAchsis,YAchsis,ZAchsis) {
    double norm_Of_g = sqrt(XAchsis * XAchsis + YAchsis * YAchsis + ZAchsis * ZAchsis);
    double y = YAchsis/norm_Of_g;
    int result = (atan(y) * (180/pi)).toInt();
    if(_normedAngle == null) {
      _normedAngle = result;
    }
    int normed = (_normedAngle - result);

    if(normed < -25) {
      _value = -25;
    }else if(normed > 25) {
      _value = 25;
    }else{
      _value = normed;
    }
  }

}
