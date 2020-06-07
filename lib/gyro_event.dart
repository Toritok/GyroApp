import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class EarableEvent extends Equatable {
  const EarableEvent();

  @override
  List<Object> get props => [];
}

class Start extends EarableEvent {}

class Stop extends EarableEvent {}

class Opened extends EarableEvent {}

class Reset extends EarableEvent {}

