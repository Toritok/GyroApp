import 'package:flutter/material.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        gradients: [
          [
            Color.fromRGBO(244, 162, 97, 1),
            Color.fromRGBO(244, 162, 97, 1),
            Color.fromRGBO(244, 162, 97, 0.7)
          ],
          [
            Color.fromRGBO(233, 196, 106, 1),
            Color.fromRGBO(233, 196, 106, 1),
            Color.fromRGBO(233, 196, 106, 0.7)
          ],
          [
            Color.fromRGBO(231, 111, 81, 1),
            Color.fromRGBO(231, 111, 81, 1),
            Color.fromRGBO(231, 111, 81, 0.7)
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
      backgroundColor: Color.fromRGBO(42, 157, 143, 1),
    );
  }
}