
import 'dart:convert';

// import 'package:http/http.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:monos/features/calender_events/models/calender_events_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class CalenderEventsRepository {
  //Restaurants Requests
  Future<List<CalenderEventsModel>> getEvents() async {
    final options = BaseOptions(
      baseUrl: "http://api.aladhan.com/v1",
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 60),
    );

    final Dio dio = Dio(options)..interceptors.addAll([
    // HttpFormatter(),
    if (kDebugMode)
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ),
    ]);

    options.headers['Accept'] = 'application/json';
    options.headers['contentType'] = 'application/json';
    Response response = await dio.get("/gToHCalendar/4/2024");

    if (response.statusCode == 200) {
      final List result = response.data["data"];
      return result.map((e) => CalenderEventsModel.fromJson(e)).toList();
    } else {
      throw Exception("An error occurred");
    }
  }
}