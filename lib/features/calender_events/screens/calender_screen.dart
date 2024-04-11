import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monos/features/calender_events/bloc/calender_events_bloc.dart';
import 'package:monos/features/calender_events/bloc/calender_events_event.dart';
import 'package:monos/features/calender_events/bloc/calender_events_state.dart';
import 'package:monos/features/calender_events/models/calender_events_model.dart';
import 'package:monos/features/calender_events/repository/calender_events_repo.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {

  final kToday = DateTime.now();
  final kFirstDay = DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);
  final kLastDay = DateTime(DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  List<CalenderEventsModel> selectedDayEvents = [];

  List<CalenderEventsModel> getEventsForDay(DateTime day) {
    // Implementation example
    final currentState = BlocProvider.of<CalenderEventsBloc>(context).state;
    if (currentState is CalenderLoadedState) {
      final kEventProvider = currentState.kEventProvider;
      // Now you can use kEventProvider as needed
      print('kEventProvider state: $kEventProvider');
      if(kEventProvider[day]==null){
        return [];
      }else{
        return kEventProvider[day]!;
      }
    } else {
      print('Current state is not CalenderLoadedState');
      return [];
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
      });

      // ref.watch(selectedEventsProvider).addAll(
      //     ref.watch(userRoutesNotifierProvider.notifier).getEventsForDay(selectedDay));
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<CalenderEventsBloc>().add(LoadCalenderEvent());
    _selectedDay = _focusedDay;
    // _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Muslim Calender", style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w900),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) =>
          CalenderEventsBloc(
            CalenderEventsRepository(),
          )
            ..add(LoadCalenderEvent()),
          child: BlocBuilder<CalenderEventsBloc, CalenderEventsState>(
            builder: (context, state) {
              if (state is CalenderLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CalenderErrorState) {
                return const Center(child:  Text("Error"));
              }
              if (state is CalenderLoadedState) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TableCalendar<CalenderEventsModel>(
                        firstDay: kFirstDay,
                        lastDay: kLastDay,
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                        rangeStartDay: _rangeStart,
                        rangeEndDay: _rangeEnd,
                        calendarFormat: _calendarFormat,
                        rangeSelectionMode: _rangeSelectionMode,
                        eventLoader: getEventsForDay,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        calendarStyle: const CalendarStyle(
                          // Use `CalendarStyle` to customize the UI
                          markerDecoration: BoxDecoration(
                              // color: Colo,
                              shape: BoxShape.circle

                          ),
                          outsideDaysVisible: false,
                        ),
                        onDaySelected: _onDaySelected,
                        onFormatChanged: (format) {
                          if (_calendarFormat != format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: ()async{
                            context.read<CalenderEventsBloc>().add(LoadCalenderEvent());
                          },
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:state.kEventProvider[_focusedDay]!=null? state.kEventProvider[_focusedDay]!.length:0,
                            itemBuilder: (context, index) {

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("${state.kEventProvider[_focusedDay]![index].hijri!.weekday!.en}",),
                                      const SizedBox(height: 15,),
                                      // Text("${ref.watch(selectedEventsProvider)[index].schedule!.date!.hour}:${ref.watch(selectedEventsProvider)[index].schedule!.date!.minute}", style: Styles.normalText(context).copyWith(fontWeight: FontWeight.w500, fontSize: 13),)
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0,),
                                    child: GestureDetector(
                                      onTap: (){
                                        // Navigator.pushNamed(context, ScheduleListScreen.route_name);
                                      },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width - 90,
                                        decoration: BoxDecoration(
                                            color: theme.primaryColor,
                                            borderRadius: const BorderRadius.all(Radius.circular(10))
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Week Day: ${state.kEventProvider[_focusedDay]![index].hijri!.weekday!.en}",
                                                style: theme.textTheme.labelLarge!.copyWith(color: Colors.white),),
                                              Text("Month: ${state.kEventProvider[_focusedDay]![index].hijri!.weekday!.en}",
                                                  style: theme.textTheme.labelLarge!.copyWith(color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                    ],
                  ),
                );
              }else{
                return SizedBox();
              }

            },
          ),
        ),
      ),
    );
  }
}
