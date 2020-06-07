import 'package:equatable/equatable.dart';

abstract class EarableState extends Equatable {
  final int value;

  const EarableState(this.value);

  @override
  List<Object> get props => [value];
}

class Ready extends EarableState {
  const Ready(int value) : super(value);

  @override
  String toString() => 'Ready { Axis: $value }';
}

class Launched extends EarableState {
  const Launched(int value) : super(value);

  @override
  String toString() => 'Launched{ Axis: $value }';
}


class Running extends EarableState {
  const Running(int value) : super(value);

  @override
  String toString() => 'Running { Axis: $value }';
}

