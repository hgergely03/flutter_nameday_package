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

// ↓ This is the part you're most probably interested in
List<FutureBuilder> _tiles = [
  // Plug the built-in method of your choice into a FutureBuilder
  // (or whatever you prefer to handle futures) and you're good to go
  FutureBuilder(
    future: Nameday.today(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        // snapshot.data is assigned to the type of class returned by the future
        // for later ease of use
        OneDayData nameDays = snapshot.data;
        return ExpansionTile(
          title: Text('Namedays today'),
          children: [
            // This fluff is where we process the data (lists) returned
            // so we get a bunch of decently pretty ExpansionTiles
            SingleChildScrollView(
              child: Column(
                children: [
                  Text('Today is ${nameDays.month}/${nameDays.day}'),
                  for (var element in nameDays.nameDays)
                    Text(
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
  ),
  FutureBuilder(
    future: Nameday.yesterday(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        OneDayData nameDays = snapshot.data;
        return ExpansionTile(
          title: Text('Namedays yesterday'),
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Text('Yesterday was ${nameDays.month}/${nameDays.day}'),
                  for (var element in nameDays.nameDays)
                    Text(
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
  ),
  FutureBuilder(
    future: Nameday.tomorrow(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        OneDayData nameDays = snapshot.data;
        return ExpansionTile(
          title: Text('Namedays tomorrow'),
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Text('Tomorrow is ${nameDays.month}/${nameDays.day}'),
                  for (var element in nameDays.nameDays)
                    Text(
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
  ),
  FutureBuilder(
    future: Nameday.specificDay(
      day: 28,
      month: 03,
    ),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        SpecificDayData nameDays = snapshot.data;
        return ExpansionTile(
          title: Text('Search nameday by day'),
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Text('Namedays on ${nameDays.month}/${nameDays.day}'),
                  for (var element in nameDays.nameDays)
                    Text(
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
  ),
  FutureBuilder(
    future: Nameday.searchByName(name: 'János', country: Countries.hu),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        SearchByNameData nameDays = snapshot.data;
        return ExpansionTile(
          title: Text('Search date by name'),
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Text('Number of results in search: ${nameDays.resultCount}'),
                  for (var result in nameDays.results)
                    Text(
                      '${result.month}/${result.day}',
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
  ),
];

// Just some text formatting because
// I can't publish an ugly example file, can I?
TextStyle _textStyle() {
  return TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w300,
  );
}
