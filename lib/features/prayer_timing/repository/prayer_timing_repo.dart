
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:monos/features/calender_events/models/calender_events_model.dart';

import '../../../services/notification_service.dart';
import '../models/prayer_timing_model.dart';


class PrayerTimingRepo {
  //Restaurants Requests
  Future<List<PrayerTimingsModel>> getEvents() async {
    Response response = await get(Uri.parse("http://api.aladhan.com/v1/calendar/2024/4?latitude=51.508515&longitude=-0.1254872&method=2 http://api.aladhan.com/v1/calendar/2019?latitude=51.508515&longitude=-0.1254872&method=2"));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      print(result);
      return result.map((e) => PrayerTimingsModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future setNotifications()async{
    List<PrayerTimingsModel> timings = await getEvents();
    timings.removeWhere((element) => element.date == null);
    timings = timings.where((element) => DateUtils.dateOnly(element.date!.gregorian!.date!)
        == DateUtils.dateOnly(DateTime.now())).toList();
    for(PrayerTimingsModel timingsModel in timings){
      print("timing ${DateUtils.dateOnly(timingsModel.date!.gregorian!.date!)} for today: ${DateUtils.dateOnly(DateTime.now())}");
    }
    PrayerTimingsModel timingsModel = timings.first;

    // Loop through timings
    timingsModel.timings!.toJson().forEach((key, value) {
      // Extract time part and remove timezone information
      String timeString = value.split('(')[0].trim();
      // Parse time string
      DateTime time = DateFormat('HH:mm').parse(timeString);
      // Create DateTime object with today's date and parsed time
      DateTime dateTime = DateTime.now().add(Duration(hours: time.hour, minutes: time.minute));
      // Schedule notification
      NotificationController.scheduleNewNotification(
          key, dateTime
      );
    });
  }

}