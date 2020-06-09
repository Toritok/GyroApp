import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyroapp/bloc/gyro_bloc.dart';
import 'package:gyroapp/bloc/gyro_state.dart';
import '../data/gyro_repo.dart';
import 'package:gyroapp/bloc/gyro_event.dart';


class ActionButtons extends StatelessWidget {
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
