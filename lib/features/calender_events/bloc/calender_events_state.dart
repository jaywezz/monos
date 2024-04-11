import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:monos/features/calender_events/models/calender_events_model.dart';

@immutable
abstract class CalenderEventsState extends Equatable {}

class CalenderLoadingState extends CalenderEventsState {
  @override
  List<Object?> get props => [];
}

class CalenderLoadedState extends CalenderEventsState {
  final List<CalenderEventsModel> events;
  final Map<DateTime, List<CalenderEventsModel>> kEventProvider;
  final List<CalenderEventsModel> selectedEventsProvider;
  CalenderLoadedState(this.events, this.selectedEventsProvider, this.kEventProvider);
  @override
  List<Object?> get props => [events];
}

class CalenderErrorState extends CalenderEventsState {
  final String error;
  CalenderErrorState(this.error);
  @override
  List<Object?> get props => [error];
}