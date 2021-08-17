import 'package:flutter/cupertino.dart';
import 'package:flutter_nameday_api/flutter_nameday_api.dart';

void main() async {
  Nameday.today();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('data');
  }
}