import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class EarableEvent extends Equatable {
  const EarableEvent();

  @override
  List<Object> get props => [];
}

class Start extends EarableEvent {
  final int value;

  const Start({@required this.value});

  @override
  String toString() => "Start { axis: $value }";
}

class Stop extends EarableEvent {}

class Opened extends EarableEvent {}

class Reset extends EarableEvent {}

