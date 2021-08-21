import 'package:flutter_nameday_api/flutter_nameday_api.dart';
import 'package:flutter_nameday_api/src/requests.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'flutter_nameday_api_test.mocks.dart';

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
          '{"status": "Success", "data": {"month": 8, "day": 22, "namedays": {"hu": "Menyhért,Mirjam"}}}';

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
      expect(oneDayRequest(when: 'today', client: client),
          throwsException);
    });
  });
}
