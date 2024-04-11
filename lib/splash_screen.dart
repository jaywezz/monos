import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monos/features/calender_events/screens/calender_screen.dart';

import 'features/calender_events/bloc/calender_events_bloc.dart';
import 'features/calender_events/repository/calender_events_repo.dart';
import 'features/prayer_timing/repository/prayer_timing_repo.dart';

class SplashScreenPage extends StatefulWidget {
  static const routeName = 'splash_screen_page';
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage> {
  // bool isLoggedin = false;


  @override
  void initState() {
    print("splash init");
    _checkUser();
    PrayerTimingRepo().setNotifications();
    super.initState();
    //Get.find<ProductCategoryController>().getProductCategories();
    // _loadResource();
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CalenderEventsBloc>(
          create: (BuildContext context) =>
              CalenderEventsBloc(CalenderEventsRepository()),
        ),
      ],
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Color(0XFF00BF62)
                // image: DecorationImage(
                //     image: AssetImage(
                //       'assets/images/bg.png',
                //     ),
                //     fit: BoxFit.fill),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                          color: Colors.transparent,
                          height: 200,
                          width: 300,
                          child: const Image(
                              image: AssetImage(
                                'assets/logos/play_store_512.png',
                              ))),
                    ),

                  ],
                ),
              ))),
    );
    // Image(image: AssetImage('assets/logos/Fresh Life Logo_Horizontal.png'))
  }

  // var storage = const FlutterSecureStorage();
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  _checkUser() async {
    Future.delayed(const Duration(milliseconds: 3000)).then((value) async {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CalenderScreen()),
      );
    });
  }
}
