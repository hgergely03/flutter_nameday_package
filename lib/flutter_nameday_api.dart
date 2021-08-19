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

Future<List<String>> _oneDayRequest(
    {required String when, Countries? countryCode}) async {
  /// Builds a request
  var request = http.Request('POST', Uri.parse(_baseURL + when));
  if (countryCode != null) {
    request.body =
        json.encode({"country": _formatCountry(country: countryCode)});
  }
  request.headers.addAll(_headers);

  /// Sends request to API then get response
  http.StreamedResponse response = await request.send();
  var data = await http.Response.fromStream(response);
  List<String> nameDays = [];

  /// Checks response
  if (data.statusCode == 200) {
    Map<String, dynamic> nameDaysWithCountryTag =
        json.decode(data.body)["data"]["namedays"] as Map<String, dynamic>;
    nameDaysWithCountryTag.forEach((key, value) {
      List<String> helper = value.toString().split(',');
      nameDays.addAll(helper);
    });
  } else {
    printError(data);
  }

  return nameDays;
}

Future<List<DateTime>> _searchByNameRequest(
    {required String name, required Countries countryCode}) async {
  /// Builds a request
  var request = http.Request('POST', Uri.parse(_baseURL + 'getdate'));
  request.body = json
      .encode({"name": name, "country": _formatCountry(country: countryCode)});
  request.headers.addAll(_headers);

  /// Sends request to API then get response
  http.StreamedResponse response = await request.send();
  var data = await http.Response.fromStream(response);
  final List<DateTime> nameDayDates = [];

  /// Checks response
  if (data.statusCode == 200) {
    var namedays = json.decode(data.body)["data"]["namedays"];
      namedays.forEach((element) {
      nameDayDates.add(DateTime(0, element["month"], element["day"]));
    });
  } else {
    printError(data);
  }

  return nameDayDates;
}

Future<List<String>> _searchSpecificDayRequest(
    {required int day,
    required int month,
    required Countries countryCode}) async {
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
  List<String> nameDaysOnDate = [];

  /// Check response
  if (data.statusCode == 200) {
    var nameDaysData = json.decode(data.body)["data"]["namedays"];
    Map<String, dynamic> nameDays = nameDaysData as Map<String, dynamic>;
    nameDays.forEach((key, value) {
      List<String> helper = value.toString().split(',');
      nameDaysOnDate.addAll(helper);
    });
  } else {
    printError(data);
  }

  return nameDaysOnDate;
}

String _formatCountry({required Countries country}) {
  String formattedCountry =
      describeEnum(country).replaceAll('_', ' ').toLowerCase();
  return formattedCountry;
}

void printError(data) {
  /// If something is amiss, notify user
  print(
      'Something went wrong while getting the namedays. Error: ${data.reasonPhrase}');
}

/// Definitely not A Calculator.
class Nameday {
  /// Returns today's namedays. Specifying a country or country code is optional.
  static Future<List<String>> today({Countries? country}) async {
    return _oneDayRequest(when: 'today', countryCode: country);
  }

  /// Returns tomorrow's namedays. Specifying a country or country code is optional.
  static Future<List<String>> tomorrow({Countries? country}) async {
    return _oneDayRequest(when: 'tomorrow', countryCode: country);
  }

  /// Returns yesterday's namedays. Specifying a country or country code is optional.
  static Future<List<String>> yesterday({Countries? country}) async {
    return _oneDayRequest(when: 'yesterday', countryCode: country);
  }

  /// Returns a month and day when the nameday of the searched name is celebrated.
  /// A name and a country or country code must be specified.
  static Future<List<DateTime>> searchByName(
      {required String name, required Countries country}) async {
    return _searchByNameRequest(name: name, countryCode: country);
  }

  /// Returns the nameday(s) celebrated on the specified day.
  /// A month, a day and a country or country code must be specified.
  static Future<List<String>> specificDay(
      {required int day,
      required int month,
      required Countries country}) async {
    return _searchSpecificDayRequest(
        countryCode: country, day: day, month: month);
  }
}
