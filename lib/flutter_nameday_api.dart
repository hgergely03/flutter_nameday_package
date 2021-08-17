library flutter_nameday_api;

import 'package:flutter/foundation.dart';
import 'package:flutter_nameday_api/country_codes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Definitely not A Calculator.
class Nameday {
  static const baseURL = 'https://nameday.abalin.net/';
  static const headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static String formatCountry({required CountryCodes country}) {
    String formattedCountry =
        describeEnum(country).replaceAll('_', ' ').toLowerCase();
    return formattedCountry;
  }

  /// Return today's namedays. Specifying a country or country code is optional.
  static Future<List<dynamic>> today({CountryCodes? country}) async {
    /// Build a request, then send it to API
    var request = http.Request('POST', Uri.parse(baseURL + 'today'));
    if (country != null) {
      request.body = json.encode({"country": formatCountry(country: country)});
    }
    request.headers.addAll(headers);

    /// Get response
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
      print('Something went wrong while getting the namedays. Error: ${data.reasonPhrase}');
    }

    return nameDays;
  }

  /// Nameday.tomorrow
  Future<List<String>> tomorrow() async {
    return [];
  }

  /// Nameday.yesterday
  Future<List<String>> yesterday() async {
    return [];
  }

  /// Nameday.searchByName
  Future<List<String>> searchByName({required String name}) async {
    return [];
  }

  /// Nameday.searchByDate
  Future<List<String>> specificDay({required DateTime date}) async {
    return [];
  }
}
