library flutter_nameday_api;

import 'package:flutter_nameday_api/country_codes.dart';
import 'package:flutter_nameday_api/models.dart';
import 'package:flutter_nameday_api/src/requests.dart';
import 'package:http/http.dart' as http;
export 'package:flutter_nameday_api/country_codes.dart';
export 'package:flutter_nameday_api/models.dart';

/// Definitely not A Calculator.
class Nameday {
  /// Returns today's namedays. Specifying a country or country code is optional.
  static Future<OneDayData> today({Countries? country}) async {
    return oneDayRequest(when: 'today', countryCode: country, client: http.Client());
  }

  /// Returns tomorrow's namedays. Specifying a country or country code is optional.
  static Future<OneDayData> tomorrow({Countries? country}) async {
    return oneDayRequest(when: 'tomorrow', countryCode: country, client: http.Client());
  }

  /// Returns yesterday's namedays. Specifying a country or country code is optional.
  static Future<OneDayData> yesterday({Countries? country}) async {
    return oneDayRequest(when: 'yesterday', countryCode: country,  client: http.Client());
  }

  /// Returns a month and day when the nameday of the searched name is celebrated.
  /// A name and a country or country code must be specified.
  static Future<SearchByNameData> searchByName(
      {required String name, required Countries country}) async {
    return searchNameDayRequest(name: name, countryCode: country, client: http.Client());
  }

  /// Returns the nameday(s) celebrated on the specified day.
  /// A month and a day must be specified.
  /// Specifying a country or country code is optional.
  static Future<SpecificDayData> specificDay(
      {required int day, required int month, Countries? country}) async {
    return specificDayRequest(countryCode: country, day: day, month: month, client: http.Client());
  }
}
