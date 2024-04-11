
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monos/features/calender_events/bloc/calender_events_event.dart';
import 'package:monos/features/calender_events/bloc/calender_events_state.dart';
import 'package:monos/features/calender_events/models/calender_events_model.dart';
import 'package:monos/features/calender_events/repository/calender_events_repo.dart';

class CalenderEventsBloc extends Bloc<CalenderEvent, CalenderEventsState> {
  final CalenderEventsRepository _calenderEventsRepository;

  CalenderEventsBloc(this._calenderEventsRepository) : super(CalenderLoadingState()) {
    on<LoadCalenderEvent>((event, emit) async {
      emit(CalenderLoadingState());
      try {
        final events = await _calenderEventsRepository.getEvents();
        final Map<DateTime, List<CalenderEventsModel>> kEvents = {};
        for (var event in events) {
          if (kEvents[DateTime.utc(event.gregorian!.date!.year, event.gregorian!.date!.month,
              event.gregorian!.date!.day)] == null) {
            kEvents[DateTime.utc(event.gregorian!.date!.year, event.gregorian!.date!.month,
                event.gregorian!.date!.day)] = [
              event
            ];
          } else {
            kEvents[DateTime.utc(event.gregorian!.date!.year, event.gregorian!.date!.month,
                event.gregorian!.date!.day)]!
                .add(event);
          }

        }
        List<CalenderEventsModel>? selectedDayEvents = kEvents[DateTime.now()] ?? [];
        emit(CalenderLoadedState(events, selectedDayEvents!, kEvents));
      } catch (e,s) {
        print(s);
        print(e);
        emit(CalenderErrorState(e.toString()));
      }
    });
  }


}