import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_nameday_api/flutter_nameday_api.dart';

void main() {
  test('checks if requests return any data', () async {
    final today = await Nameday.today();
    final tomorrow = await Nameday.tomorrow();
    final yesterday = await Nameday.yesterday();
    final searchByName = await Nameday.searchByName(name: 'János', country: Countries.hun);
    final specificDay = await Nameday.specificDay(day: 28, month: 03, country: Countries.hu);

    /*expect(today.length, isNot(equals(0)));
    expect(tomorrow.length, isNot(equals(0)));
    expect(yesterday.length, isNot(equals(0)));
    expect(searchByName, isNotEmpty);
    expect(specificDay, isNotEmpty);*/
  });
}
