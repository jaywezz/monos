// To parse this JSON data, do
//
//     final prayerTimingsModel = prayerTimingsModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';


String prayerTimingsModelToJson(PrayerTimingsModel data) => json.encode(data.toJson());



class PrayerTimingsModel {
  Timings? timings;
  Date? date;
  Meta? meta;

  PrayerTimingsModel({
    this.timings,
    this.date,
    this.meta,
  });

  factory PrayerTimingsModel.fromJson(Map<String, dynamic> json) => PrayerTimingsModel(
    timings: json["timings"] == null ? null : Timings.fromJson(json["timings"]),
    date: json["date"] == null ? null : Date.fromJson(json["date"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "timings": timings?.toJson(),
    "date": date?.toJson(),
    "meta": meta?.toJson(),
  };
}

class Date {
  String? readable;
  String? timestamp;
  Gregorian? gregorian;
  Hijri? hijri;

  Date({
    this.readable,
    this.timestamp,
    this.gregorian,
    this.hijri,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    readable: json["readable"],
    timestamp: json["timestamp"],
    gregorian: json["gregorian"] == null ? null : Gregorian.fromJson(json["gregorian"]),
    hijri: json["hijri"] == null ? null : Hijri.fromJson(json["hijri"]),
  );

  Map<String, dynamic> toJson() => {
    "readable": readable,
    "timestamp": timestamp,
    "gregorian": gregorian?.toJson(),
    "hijri": hijri?.toJson(),
  };
}

class Gregorian {
  DateTime? date;
  Format? format;
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
    date: DateFormat('dd-MM-yyyy').parse(json["date"]),
    format: formatValues.map[json["format"]]!,
    day: json["day"],
    weekday: json["weekday"] == null ? null : GregorianWeekday.fromJson(json["weekday"]),
    month: json["month"] == null ? null : GregorianMonth.fromJson(json["month"]),
    year: json["year"],
    designation: json["designation"] == null ? null : Designation.fromJson(json["designation"]),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "format": formatValues.reverse[format],
    "day": day,
    "weekday": weekday?.toJson(),
    "month": month?.toJson(),
    "year": year,
    "designation": designation?.toJson(),
  };
}

class Designation {
  Abbreviated? abbreviated;
  Expanded? expanded;

  Designation({
    this.abbreviated,
    this.expanded,
  });

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
    abbreviated: abbreviatedValues.map[json["abbreviated"]]!,
    expanded: expandedValues.map[json["expanded"]]!,
  );

  Map<String, dynamic> toJson() => {
    "abbreviated": abbreviatedValues.reverse[abbreviated],
    "expanded": expandedValues.reverse[expanded],
  };
}

enum Abbreviated {
  AD,
  AH
}

final abbreviatedValues = EnumValues({
  "AD": Abbreviated.AD,
  "AH": Abbreviated.AH
});

enum Expanded {
  ANNO_DOMINI,
  ANNO_HEGIRAE
}

final expandedValues = EnumValues({
  "Anno Domini": Expanded.ANNO_DOMINI,
  "Anno Hegirae": Expanded.ANNO_HEGIRAE
});

enum Format {
  DD_MM_YYYY
}

final formatValues = EnumValues({
  "DD-MM-YYYY": Format.DD_MM_YYYY
});

class GregorianMonth {
  int? number;
  PurpleEn? en;

  GregorianMonth({
    this.number,
    this.en,
  });

  factory GregorianMonth.fromJson(Map<String, dynamic> json) => GregorianMonth(
    number: json["number"],
    en: purpleEnValues.map[json["en"]]!,
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "en": purpleEnValues.reverse[en],
  };
}

enum PurpleEn {
  APRIL
}

final purpleEnValues = EnumValues({
  "April": PurpleEn.APRIL
});

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
  Format? format;
  String? day;
  HijriWeekday? weekday;
  HijriMonth? month;
  String? year;
  Designation? designation;
  List<String>? holidays;

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
    format: formatValues.map[json["format"]]!,
    day: json["day"],
    weekday: json["weekday"] == null ? null : HijriWeekday.fromJson(json["weekday"]),
    month: json["month"] == null ? null : HijriMonth.fromJson(json["month"]),
    year: json["year"],
    designation: json["designation"] == null ? null : Designation.fromJson(json["designation"]),
    holidays: json["holidays"] == null ? [] : List<String>.from(json["holidays"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "format": formatValues.reverse[format],
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
  FluffyEn? en;
  Ar? ar;

  HijriMonth({
    this.number,
    this.en,
    this.ar,
  });

  factory HijriMonth.fromJson(Map<String, dynamic> json) => HijriMonth(
    number: json["number"],
    en: fluffyEnValues.map[json["en"]]!,
    ar: arValues.map[json["ar"]]!,
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "en": fluffyEnValues.reverse[en],
    "ar": arValues.reverse[ar],
  };
}

enum Ar {
  AR,
  EMPTY
}

final arValues = EnumValues({
  "شَوّال": Ar.AR,
  "رَمَضان": Ar.EMPTY
});

enum FluffyEn {
  RAMAN,
  SHAWWL
}

final fluffyEnValues = EnumValues({
  "Ramaḍān": FluffyEn.RAMAN,
  "Shawwāl": FluffyEn.SHAWWL
});

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

class Meta {
  double? latitude;
  double? longitude;
  Timezone? timezone;
  Method? method;
  LatitudeAdjustmentMethod? latitudeAdjustmentMethod;
  MidnightMode? midnightMode;
  MidnightMode? school;
  Map<String, int>? offset;

  Meta({
    this.latitude,
    this.longitude,
    this.timezone,
    this.method,
    this.latitudeAdjustmentMethod,
    this.midnightMode,
    this.school,
    this.offset,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    timezone: timezoneValues.map[json["timezone"]]!,
    method: json["method"] == null ? null : Method.fromJson(json["method"]),
    latitudeAdjustmentMethod: latitudeAdjustmentMethodValues.map[json["latitudeAdjustmentMethod"]]!,
    midnightMode: midnightModeValues.map[json["midnightMode"]]!,
    school: midnightModeValues.map[json["school"]]!,
    offset: Map.from(json["offset"]!).map((k, v) => MapEntry<String, int>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "timezone": timezoneValues.reverse[timezone],
    "method": method?.toJson(),
    "latitudeAdjustmentMethod": latitudeAdjustmentMethodValues.reverse[latitudeAdjustmentMethod],
    "midnightMode": midnightModeValues.reverse[midnightMode],
    "school": midnightModeValues.reverse[school],
    "offset": Map.from(offset!).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

enum LatitudeAdjustmentMethod {
  ANGLE_BASED
}

final latitudeAdjustmentMethodValues = EnumValues({
  "ANGLE_BASED": LatitudeAdjustmentMethod.ANGLE_BASED
});

class Method {
  int? id;
  Name? name;
  Params? params;
  Location? location;

  Method({
    this.id,
    this.name,
    this.params,
    this.location,
  });

  factory Method.fromJson(Map<String, dynamic> json) => Method(
    id: json["id"],
    name: nameValues.map[json["name"]]!,
    params: json["params"] == null ? null : Params.fromJson(json["params"]),
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "params": params?.toJson(),
    "location": location?.toJson(),
  };
}

class Location {
  double? latitude;
  double? longitude;

  Location({
    this.latitude,
    this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

enum Name {
  ISLAMIC_SOCIETY_OF_NORTH_AMERICA_ISNA
}

final nameValues = EnumValues({
  "Islamic Society of North America (ISNA)": Name.ISLAMIC_SOCIETY_OF_NORTH_AMERICA_ISNA
});

class Params {
  int? fajr;
  int? isha;

  Params({
    this.fajr,
    this.isha,
  });

  factory Params.fromJson(Map<String, dynamic> json) => Params(
    fajr: json["Fajr"],
    isha: json["Isha"],
  );

  Map<String, dynamic> toJson() => {
    "Fajr": fajr,
    "Isha": isha,
  };
}

enum MidnightMode {
  STANDARD
}

final midnightModeValues = EnumValues({
  "STANDARD": MidnightMode.STANDARD
});

enum Timezone {
  EUROPE_LONDON
}

final timezoneValues = EnumValues({
  "Europe/London": Timezone.EUROPE_LONDON
});

class Timings {
  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? sunset;
  String? maghrib;
  String? isha;
  String? imsak;
  String? midnight;
  String? firstthird;
  String? lastthird;

  Timings({
    this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.sunset,
    this.maghrib,
    this.isha,
    this.imsak,
    this.midnight,
    this.firstthird,
    this.lastthird,
  });

  factory Timings.fromJson(Map<String, dynamic> json) => Timings(
    fajr: json["Fajr"],
    sunrise: json["Sunrise"],
    dhuhr: json["Dhuhr"],
    asr: json["Asr"],
    sunset: json["Sunset"],
    maghrib: json["Maghrib"],
    isha: json["Isha"],
    imsak: json["Imsak"],
    midnight: json["Midnight"],
    firstthird: json["Firstthird"],
    lastthird: json["Lastthird"],
  );

  Map<String, dynamic> toJson() => {
    "Fajr": fajr,
    "Sunrise": sunrise,
    "Dhuhr": dhuhr,
    "Asr": asr,
    "Sunset": sunset,
    "Maghrib": maghrib,
    "Isha": isha,
    "Imsak": imsak,
    "Midnight": midnight,
    "Firstthird": firstthird,
    "Lastthird": lastthird,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
