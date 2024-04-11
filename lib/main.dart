import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:monos/features/calender_events/screens/calender_screen.dart';
import 'package:monos/splash_screen.dart';
import 'package:monos/services/notification_service.dart';

import 'features/calender_events/bloc/calender_events_bloc.dart';
import 'features/calender_events/repository/calender_events_repo.dart';
import 'features/prayer_timing/repository/prayer_timing_repo.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await TokenStorage().removeAccessToken();

  await NotificationController.initializeLocalNotifications();
  PrayerTimingRepo().setNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      key: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0XFF00BF62)),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
          providers: [
            BlocProvider<CalenderEventsBloc>(
              create: (BuildContext context) =>
                  CalenderEventsBloc(CalenderEventsRepository()),
            ),
          ],
          child: const CalenderScreen()),
    );
  }
}

