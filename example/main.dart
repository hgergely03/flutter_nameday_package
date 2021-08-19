import 'package:flutter/cupertino.dart';
import 'package:flutter_nameday_api/flutter_nameday_api.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Nameday.today(country: Countries.Hungary),
      builder: (context, snapshot) => Text(snapshot.data.toString()),
    );
  }
}
