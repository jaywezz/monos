// To parse this JSON data, do
//
//     final calenderEventsModel = calenderEventsModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

List<CalenderEventsModel> calenderEventsFromJson(dynamic str) => List<CalenderEventsModel>.from(
  (str).map(
        (e) => CalenderEventsModel.fromJson(e),
  ),
);

// To parse this JSON data, do
//
//     final calenderEventsModel = calenderEventsModelFromJson(jsonString);

String calenderEventsModelToJson(CalenderEventsModel data) => json.encode(data.toJson());

class CalenderEventsModel {
  Hijri? hijri;
  Gregorian? gregorian;

  CalenderEventsModel({
    this.hijri,
    this.gregorian,
  });

  factory CalenderEventsModel.fromJson(Map<String, dynamic> json) => CalenderEventsModel(
    hijri: json["hijri"] == null ? null : Hijri.fromJson(json["hijri"]),
    gregorian: json["gregorian"] == null ? null : Gregorian.fromJson(json["gregorian"]),
  );

  Map<String, dynamic> toJson() => {
    "hijri": hijri?.toJson(),
    "gregorian": gregorian?.toJson(),
  };
}

class Gregorian {
  DateTime? date;
  String? format;
  String? day;
  GregorianWeekday? weekday;
  GregorianMonth? month;
  String? year;
  Designation? designation;

  Gregorian({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
    this.designation,
  });

  factory Gregorian.fromJson(Map<String, dynamic> json) => Gregorian(
    date: DateFormat("dd-MM-yyyy").parse(json["date"]),
    format: json["format"],
    day: json["day"],
    weekday: json["weekday"] == null ? null : GregorianWeekday.fromJson(json["weekday"]),
    month: json["month"] == null ? null : GregorianMonth.fromJson(json["month"]),
    year: json["year"],
    designation: json["designation"] == null ? null : Designation.fromJson(json["designation"]),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "format": format,
    "day": day,
    "weekday": weekday?.toJson(),
    "month": month?.toJson(),
    "year": year,
    "designation": designation?.toJson(),
  };
}

class Designation {
  String? abbreviated;
  String? expanded;

  Designation({
    this.abbreviated,
    this.expanded,
  });

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
    abbreviated: json["abbreviated"],
    expanded: json["expanded"],
  );

  Map<String, dynamic> toJson() => {
    "abbreviated": abbreviated,
    "expanded": expanded,
  };
}

class GregorianMonth {
  int? number;
  String? en;

  GregorianMonth({
    this.number,
    this.en,
  });

  factory GregorianMonth.fromJson(Map<String, dynamic> json) => GregorianMonth(
    number: json["number"],
    en: json["en"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "en": en,
  };
}

class GregorianWeekday {
  String? en;

  GregorianWeekday({
    this.en,
  });

  factory GregorianWeekday.fromJson(Map<String, dynamic> json) => GregorianWeekday(
    en: json["en"],
  );

  Map<String, dynamic> toJson() => {
    "en": en,
  };
}

class Hijri {
  String? date;
  String? format;
  String? day;
  HijriWeekday? weekday;
  HijriMonth? month;
  String? year;
  Designation? designation;
  List<dynamic>? holidays;

  Hijri({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
    this.designation,
    this.holidays,
  });

  factory Hijri.fromJson(Map<String, dynamic> json) => Hijri(
    date: json["date"],
    format: json["format"],
    day: json["day"],
    weekday: json["weekday"] == null ? null : HijriWeekday.fromJson(json["weekday"]),
    month: json["month"] == null ? null : HijriMonth.fromJson(json["month"]),
    year: json["year"],
    designation: json["designation"] == null ? null : Designation.fromJson(json["designation"]),
    holidays: json["holidays"] == null ? [] : List<dynamic>.from(json["holidays"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "format": format,
    "day": day,
    "weekday": weekday?.toJson(),
    "month": month?.toJson(),
    "year": year,
    "designation": designation?.toJson(),
    "holidays": holidays == null ? [] : List<dynamic>.from(holidays!.map((x) => x)),
  };
}

class HijriMonth {
  int? number;
  String? en;
  String? ar;

  HijriMonth({
    this.number,
    this.en,
    this.ar,
  });

  factory HijriMonth.fromJson(Map<String, dynamic> json) => HijriMonth(
    number: json["number"],
    en: json["en"],
    ar: json["ar"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "en": en,
    "ar": ar,
  };
}

class HijriWeekday {
  String? en;
  String? ar;

  HijriWeekday({
    this.en,
    this.ar,
  });

  factory HijriWeekday.fromJson(Map<String, dynamic> json) => HijriWeekday(
    en: json["en"],
    ar: json["ar"],
  );

  Map<String, dynamic> toJson() => {
    "en": en,
    "ar": ar,
  };
}
