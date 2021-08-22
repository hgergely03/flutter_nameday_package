import 'package:flutter_nameday_api/country_codes.dart';
import 'package:flutter_nameday_api/models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const _baseURL = 'https://nameday.abalin.net/';
const _headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};

/// Formats countries from enum to API-readable version
String _formatCountry({required Countries country}) {
  String formattedCountry =
      describeEnum(country).replaceAll('_', ' ').toLowerCase();
  return formattedCountry;
}

/// If something is amiss, notify user
void _printError(data) {
  print(
      'Something went wrong while getting the namedays. Error: ${data.reasonPhrase}');
}

/// Function that handles requests for today(), yesterday(), tomorrow()
Future<OneDayData> oneDayRequest(
    {required String when,
    Countries? countryCode,
    required http.Client client}) async {
  bool countrySpecified = countryCode != null;
  final data = await client.post(Uri.parse(_baseURL + when),
      headers: _headers,
      body: countrySpecified
          ? json.encode({"country": _formatCountry(country: countryCode)})
          : null);

  if (data.statusCode == 200) {
    return OneDayData.fromJson(json.decode(data.body));
  } else {
    // _printError(data);
    throw Exception('Fail');
  }
}

/// Handles requests for searchByName()
Future<SearchByNameData> searchNameDayRequest(
    {required String name,
    required Countries countryCode,
    required http.Client client}) async {
  final data = await client.post(Uri.parse(_baseURL + 'getdate'),
      headers: _headers,
      body: json.encode(
          {"name": name, "country": _formatCountry(country: countryCode)}));

  if (data.statusCode == 200) {
    return SearchByNameData.fromJson(json.decode(data.body));
  } else {
    _printError(data);
    throw Exception('Fail');
  }
}

/// Handles requests for specificDay()
Future<SpecificDayData> specificDayRequest(
    {required int day,
    required int month,
    required Countries? countryCode,
    required http.Client client}) async {
  bool countrySpecified = countryCode != null;
  final data = await client.post(Uri.parse(_baseURL + 'namedays'),
      headers: _headers,
      body: countrySpecified
          ? json.encode({
              "country": _formatCountry(country: countryCode),
              "day": day,
              "month": month
            })
          : json.encode({"day": day, "month": month}));

  if (data.statusCode == 200) {
    return SpecificDayData.fromJson(json.decode(data.body));
  } else {
    _printError(data);
    throw Exception('Fail');
  }
}
