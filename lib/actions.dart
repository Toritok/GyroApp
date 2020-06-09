import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyroapp/gyro_bloc.dart';
import 'package:gyroapp/gyro_event.dart';
import 'package:gyroapp/gyro_state.dart';


class Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButtons(
        earableBloc: BlocProvider.of<EarableBloc>(context),
      ),
    );
  }

  List<Widget> _mapStateToActionButtons({
    EarableBloc earableBloc,
  }) {
    final EarableState currentState = earableBloc.state;
    if (currentState is Launched) {
      return [
        FloatingActionButton(
          child: Icon(Icons.bluetooth),
          onPressed: () =>
              earableBloc.add(Opened()),
        ),
      ];
    }
    if (currentState is Ready) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () =>
              earableBloc.add(Start()),
        ),
      ];
    }
    if (currentState is Running) {
      return [
        FloatingActionButton(
          child: Icon(Icons.stop),
          onPressed: () => earableBloc.add(Stop()),
        ),
        FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () => earableBloc.add(Reset()),
        ),
      ];
    }
    return [];
  }
}