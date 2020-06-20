import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyroapp/bloc/gyro_bloc.dart';
import 'package:gyroapp/bloc/gyro_state.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'background_screen.dart';
import 'buttons.dart';





class AxisUI extends StatelessWidget {
  static const TextStyle labelTextStyle = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(38,70,83, 1),
  );
  static const TextStyle mainLabelStyle = TextStyle(
    color: Color.fromRGBO(38,70,83, 0),
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
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Center(
                  child: BlocBuilder<EarableBloc, EarableState>(
                    builder: (context, state) {
                      final int axisDeg = state.value
                          .floor();
                      final String axisAdvice = _getAdvice(state.value);

                      return SleekCircularSlider(
                        appearance: CircularSliderAppearance(
                          size: 300,
                          angleRange: 180,
                          startAngle: 180,
                          customWidths: CustomSliderWidths(progressBarWidth: 30, handlerSize: 22, trackWidth: 30),
                          customColors: CustomSliderColors(progressBarColor: Color.fromRGBO(0,0,0, 0),trackColor: Color.fromRGBO(38,70,83, 1),hideShadow: true),
                          infoProperties: InfoProperties(bottomLabelText: axisAdvice, mainLabelStyle: mainLabelStyle, bottomLabelStyle: labelTextStyle ),

                        ),
                        min: -25,
                        max: 25,
                        initialValue: -axisDeg.toDouble(),
                      );
                    },
                  ),
                ),
              ),
              BlocBuilder<EarableBloc, EarableState>(

                condition: (previousState, state) =>
                state.runtimeType != previousState.runtimeType,
                builder: (context, state) => ActionButtons(),

              ),
            ],
          ),
        ],
      ),
    );
  }
  String _getAdvice(int value) {
    String advice;
    if(-value < -10) {
      advice = "Urlaub";
    }else if(-value > 10) {
      advice = "Buckel";
    }else {
      advice = "1A";
    }
    return advice;
  }
}
