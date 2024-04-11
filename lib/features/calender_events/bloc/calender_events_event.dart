import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class CalenderEvent extends Equatable {
  const CalenderEvent();
}

class LoadCalenderEvent extends CalenderEvent {
  @override
  List<Object?> get props => [];
}