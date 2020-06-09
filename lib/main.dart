import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gyroapp/ui/screen_UI.dart';
import 'data/gyro_repo.dart';
import 'bloc/gyro_bloc.dart';


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
        child: AxisUI(),
      ),
    );
  }
}



