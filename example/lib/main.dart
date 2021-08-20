import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_nameday_api/flutter_nameday_api.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Nameday API'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: _tiles,
          ),
        ),
      ),
    );
  }
}

/// Here we specify the title of the Expansion titles
/// and what kind of data we would like to see when opened
List<FutureBuilder> _tiles = [
  _builder('Namedays today', Nameday.today()),
  _builder('Namedays tomorrow', Nameday.tomorrow()),
  _builder('Namedays yesterday', Nameday.yesterday()),
  _builder('Search nameday by day',
      Nameday.specificDay(day: 28, month: 03, country: Countries.Hungary)),
  _builder('Search date by name',
      Nameday.searchByName(name: 'János', country: Countries.hu)),
];

/// ↓ This is the part you're most probably interested in
FutureBuilder _builder(String title, Future<dynamic> future) {
  return FutureBuilder(
    /// Plug the built-in method of your choice into a FutureBuilder
    /// (or whatever you prefer to handle futures) and you're good to go
    future: future,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ExpansionTile(
          title: Text(title),
          children: [
            /// This fluff is where we process the data (lists) returned
            /// so we get a bunch of pretty ExpansionTiles
            SingleChildScrollView(
              child: Column(
                children: [
                  for (var element in snapshot.data)
                    element.runtimeType == DateTime
                        ? Text(
                            'Month: ${element.month} Day: ${element.day}',
                            style: _textStyle(),
                          )
                        : Text(
                            element,
                            style: _textStyle(),
                          ),
                ],
              ),
            ),
          ],
        );
      } else {
        return CircularProgressIndicator();
      }
    },
  );
}

/// Just some text formatting because
/// I can't publish an ugly example file, can I?
TextStyle _textStyle() {
  return TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w300,
  );
}
