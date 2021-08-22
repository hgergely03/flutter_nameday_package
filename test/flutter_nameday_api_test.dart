import 'package:flutter_nameday_api/flutter_nameday_api.dart';
import 'package:flutter_nameday_api/src/requests.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'flutter_nameday_api_test.mocks.dart';
import 'dart:convert';

@GenerateMocks([http.Client])
void main() {
  const _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  group('oneDayRequest', () {
    // Test successful response
    test('returns a OneDayData if the http call completes successfully',
        () async {
      final client = MockClient();
      String jsonResponse =
          '{"status": "Success", "data": {"month": 8, "day": 23, "namedays": {"hu": "Bence"}}}';

      when(client.post(Uri.parse('https://nameday.abalin.net/today'),
              headers: _headers))
          .thenAnswer(
              (realInvocation) async => http.Response(jsonResponse, 200));
      expect(await oneDayRequest(when: 'today', client: client),
          isA<OneDayData>());
    });

    // Test unsuccessful response
    test('throws an exception if the http call completes with an error',
        () async {
      final client = MockClient();

      when(client.post(Uri.parse('https://nameday.abalin.net/today'),
              headers: _headers))
          .thenAnswer(
              (realInvocation) async => http.Response('Not found', 404));
      expect(oneDayRequest(when: 'today', client: client), throwsException);
    });
  });

  group('searchByNameRequest', () {
    // Test successful response
    test('returns a SearchByName if the http call completes successfully',
        () async {
      final client = MockClient();
      String jsonResponse =
          '{"status":"Success","data":{"resultCount":1,"namedays":[{"day":23,"month":4,"name":"Béla","countryCode":"HU","countryName":"Hungary"}]}}';

      when(client.post(Uri.parse('https://nameday.abalin.net/getdate'),
              headers: _headers,
              body: json.encode({"name": 'Béla', "country": "hu"})))
          .thenAnswer(
              (realInvocation) async => http.Response(jsonResponse, 200));
      expect(
          await searchNameDayRequest(
              name: 'Béla', countryCode: Countries.hu, client: client),
          isA<SearchByName>());
    });

    // Test unsuccessful response
    test('throws an exception if the http call completes with an error',
        () async {
      final client = MockClient();

      when(client.post(Uri.parse('https://nameday.abalin.net/getdate'),
              headers: _headers,
              body: json.encode({"name": 'Béla', "country": "hu"})))
          .thenAnswer(
              (realInvocation) async => http.Response('Not found', 404));
      expect(
          searchNameDayRequest(
              name: 'Béla', countryCode: Countries.hu, client: client),
          throwsException);
    });
  });

  group('specificDayRequest', () {
    // Test successful response
    test('returns a SpecificDay if the http call completes successfully',
        () async {
      final client = MockClient();
      String jsonResponse =
          '{"status":"Success","data":{"date":"02/28","namedays":{"se":"Maria"}}}';

      when(client.post(Uri.parse('https://nameday.abalin.net/namedays'),
              headers: _headers,
              body: json.encode({"country": "sweden", "day": 28, "month": 2})))
          .thenAnswer(
              (realInvocation) async => http.Response(jsonResponse, 200));
      expect(
          await specificDayRequest(
              day: 28, month: 2, countryCode: Countries.Sweden, client: client),
          isA<SpecificDay>());
    });

    // Test unsuccessful response
    test('throws an exception if the http call completes with an error',
        () async {
      final client = MockClient();

      when(client.post(Uri.parse('https://nameday.abalin.net/namedays'),
              headers: _headers,
              body: json.encode({"country": "sweden", "day": 28, "month": 2})))
          .thenAnswer(
              (realInvocation) async => http.Response('Not found', 404));
      expect(
          specificDayRequest(
              day: 28, month: 2, countryCode: Countries.Sweden, client: client),
          throwsException);
    });
  });
}
