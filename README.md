<h1 align="center">
    Flutter nameday API
</h1>

<h2 align="center">A Flutter wrapper for Abalin.net nameday API</h2>

# Table of contents
<!-- - [Installing](#install) -->
- [List of supported countries](#countries)
- [Usage](#usage)

<!-- # <a name="install"></a>Installing
### 1. Depend on it

Add this to your package's pubspec.yaml file:
    
    dependencies:
        flutter_nameday_api: ^1.0.0

### 2. Install it
You can install packages from the command line:

with `pub`:

    $ pub get

with `Flutter`:

    $ flutter pub get

### 3. Import it
Now in your `Dart` code, you can use:

    import 'package:flutter_nameday_api/flutter_nameday_api.dart'; -->

# <a name="countries"></a>Supported countries
- Austria
- Czechia
- Finland
- Greece
- Latvia
- Russian Federation
- Sweden
- Bulgaria
- Denmark
- France
- Hungary
- Lithuania
- Slovakia
- United States of America
- Croatia
- Estonia
- Germany
- Italy
- Poland
- Spain

# <a name="usage"></a>Usage

### Built-in methods
| Method                 | Description                               | Arguments           |
|------------------------|-------------------------------------------|---------------------|
| Nameday.today()        | Get namedays celebrated today             | country             |
| Nameday.tomorrow()     | Get namedays celebrated tomorrow          | country             |
| Nameday.yesterday()    | Get namedays celebrated yesterday         | country             |
| Nameday.searchByName() | Get the date when a nameday is celebrated | name, country       |
| Nameday.specificDay()  | Get nameday(s) on a specific day          | country, day, month |

[More in Dart docs]()

### Example

All the above methods return their respective future classes, so just plug them into a FutureBuilder and you're good to go:

    FutureBuilder(
      future: Nameday.today(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          /// snapshot.data is assigned to the type of class returned by the future
          /// for later ease of use
          OneDayData nameDays = snapshot.data;
          return ExpansionTile(
            title: Text('Namedays today'),
            children: [
              /// This fluff is where we process the data (lists) returned
              /// so we get a bunch of decently pretty ExpansionTiles
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

You can see a longer example with all the methods in examples.

![Much namedays, such tiles!](doc/example_screenshot.png)

# Features, bugs and feedback
Did you encounter any problems while using this package? Would you like to see a feature added to it? Feel free to create an issue [here](https://github.com/hgergely03/flutter_nameday_package/issues) or send a pull request my way!