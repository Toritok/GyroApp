import 'package:equatable/equatable.dart';

abstract class EarableEvent extends Equatable {
  const EarableEvent();

  @override
  List<Object> get props => [];
}

class Start extends EarableEvent {}

class Stop extends EarableEvent {}

class Opened extends EarableEvent {}

class Reset extends EarableEvent {}

class Connected extends EarableEvent {}

class AxisUpdate extends EarableEvent {}

class ButtonUpdate extends EarableEvent {}

