library flutter_nameday_api;

import 'package:flutter/foundation.dart';
import 'package:flutter_nameday_api/country_codes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
export 'package:flutter_nameday_api/country_codes.dart';

const _baseURL = 'https://nameday.abalin.net/';
const _headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};

Future<List<dynamic>> _oneDayRequest(
    {required String when, CountryCodes? countryCode}) async {
  /// Build a request
  var request = http.Request('POST', Uri.parse(_baseURL + when));
  if (countryCode != null) {
    request.body =
        json.encode({"country": _formatCountry(country: countryCode)});
  }
  request.headers.addAll(_headers);

  /// Send request to API then get response
  http.StreamedResponse response = await request.send();
  var data = await http.Response.fromStream(response);
  List<dynamic> nameDays = [];

  /// Check response
  if (data.statusCode == 200) {
    Map<String, dynamic> nameDaysWithCountryTag =
        json.decode(data.body)["data"]["namedays"] as Map<String, dynamic>;
    nameDays.addAll(nameDaysWithCountryTag.values);
  } else {
    /// If something is amiss, notify user
    print(
        'Something went wrong while getting the namedays. Error: ${data.reasonPhrase}');
  }

  return nameDays;
}

Future<DateTime> _searchByNameRequest(
    {required String name, required CountryCodes countryCode}) async {
  /// Build a request
  var request = http.Request('POST', Uri.parse(_baseURL + 'getdate'));
  request.body = json
      .encode({"name": name, "country": _formatCountry(country: countryCode)});
  request.headers.addAll(_headers);

  /// Send request to API then get response
  http.StreamedResponse response = await request.send();
  var data = await http.Response.fromStream(response);
  DateTime nameDayDate = DateTime(1999, 01, 01);

  /// Check response
  if (data.statusCode == 200) {
    var namedays = json.decode(data.body)["data"]["namedays"];
    Map<String, dynamic> nameDayProperties =
        namedays.first as Map<String, dynamic>;

    nameDayDate =
        DateTime(1999, nameDayProperties["month"], nameDayProperties["day"]);
    print('Month: ${nameDayDate.month} day: ${nameDayDate.day}');
  } else {
    /// If something is amiss, notify user
    print(
        'Something went wrong while getting the namedays. Error: ${data.reasonPhrase}');
  }

  return nameDayDate;
}

Future<List<dynamic>> _searchSpecificDayRequest(
    {required int day,
    required int month,
    required CountryCodes countryCode}) async {
  /// Build a request
  var request = http.Request('POST', Uri.parse(_baseURL + 'namedays'));
  request.body = json.encode({
    "country": _formatCountry(country: countryCode),
    "day": day,
    "month": month
  });
  request.headers.addAll(_headers);

  /// Send request to API then get response
  http.StreamedResponse response = await request.send();
  var data = await http.Response.fromStream(response);
  List<dynamic> nameDaysOnDate = [];

  /// Check response
  if (data.statusCode == 200) {
    var nameDaysData = json.decode(data.body)["data"]["namedays"];
    Map<String, dynamic> nameDays = nameDaysData as Map<String, dynamic>;
    nameDaysOnDate.addAll(nameDays.values);
  } else {
    /// If something is amiss, notify user
    print(
        'Something went wrong while getting the namedays. Error: ${data.reasonPhrase}');
  }

  return nameDaysOnDate;
}

String _formatCountry({required CountryCodes country}) {
  String formattedCountry =
      describeEnum(country).replaceAll('_', ' ').toLowerCase();
  return formattedCountry;
}

/// Definitely not A Calculator.
class Nameday {
  /// Return today's namedays. Specifying a country or country code is optional.
  static Future<List<dynamic>> today({CountryCodes? country}) async {
    return _oneDayRequest(when: 'today', countryCode: country);
  }

  /// Return tomorrow's namedays. Specifying a country or country code is optional.
  static Future<List<dynamic>> tomorrow({CountryCodes? country}) async {
    return _oneDayRequest(when: 'tomorrow', countryCode: country);
  }

  /// Return yesterday's namedays. Specifying a country or country code is optional.
  static Future<List<dynamic>> yesterday({CountryCodes? country}) async {
    return _oneDayRequest(when: 'yesterday', countryCode: country);
  }

  /// Return a month and day when the nameday of the searched name is celebrated. A country must be specified.
  static Future<DateTime> searchByName(
      {required String name, required CountryCodes country}) async {
    return _searchByNameRequest(name: name, countryCode: country);
  }

  /// Return the nameday(s) celebrated on the specified day
  static Future<List<dynamic>> specificDay(
      {required int day,
      required int month,
      required CountryCodes country}) async {
    return _searchSpecificDayRequest(
        countryCode: country, day: day, month: month);
  }
}
