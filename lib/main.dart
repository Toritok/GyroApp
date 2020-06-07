import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyroapp/gyro_bloc.dart';
import 'package:gyroapp/gyro_event.dart';
import 'package:gyroapp/gyro_state.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';

import 'gyro_repo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(38,70,83, 1),
        accentColor: Color.fromRGBO(38,70,83, 1),
        brightness: Brightness.dark,
      ),
      title: 'Gyro App',
      home: BlocProvider(
        create: (context) => EarableBloc(earable: ESenseRepo()),
        child: Axis(),
      ),
    );
  }
}

class Axis extends StatelessWidget {
  static const TextStyle axisTextStyle = TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sitting Right')),
      body: Stack(
        children: [
          Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100.0),
                child: Center(
                  child: BlocBuilder<EarableBloc, EarableState>(
                    builder: (context, state) {
                      final String axisStr = state.value
                          .floor()
                          .toString();

                      return Text(
                        '$axisStr',
                        style: Axis.axisTextStyle,
                      );
                    },
                  ),
                ),
              ),
              BlocBuilder<EarableBloc, EarableState>(
                condition: (previousState, state) =>
                state.runtimeType != previousState.runtimeType,
                builder: (context, state) => Actions(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        gradients: [
          [
            Color.fromRGBO(244,162,97, 1),
            Color.fromRGBO(244,162,97, 1),
            Color.fromRGBO(244,162,97, 0.7)
          ],
          [
            Color.fromRGBO(233,196,106, 1),
            Color.fromRGBO(233,196,106, 1),
            Color.fromRGBO(233,196,106, 0.7)
          ],
          [
            Color.fromRGBO(231,111,81, 1),
            Color.fromRGBO(231,111,81, 1),
            Color.fromRGBO(231,111,81, 0.7)
          ],
        ],
        durations: [19440, 10800, 6000],
        heightPercentages: [0.03, 0.01, 0.02],
        blur: MaskFilter.blur(BlurStyle.inner, 10),
        gradientBegin: Alignment.bottomCenter,
        gradientEnd: Alignment.topCenter,
      ),
      size: Size(double.infinity, double.infinity),
      waveAmplitude: 25,
      backgroundColor: Color.fromRGBO(42,157,143, 1),
    );
  }
}