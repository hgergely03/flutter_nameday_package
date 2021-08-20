class OneDayData {
  final int month;
  final int day;
  final List<String> nameDays;
  final Map<String, List<String>> nameDaysWithCodes;

  OneDayData(
      {required this.month,
        required this.day,
        required this.nameDays,
        required this.nameDaysWithCodes});

  factory OneDayData.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> namesWithCodes = json["data"]["namedays"];
    Map<String, List<String>> countryCodesHelper =
    new Map<String, List<String>>();
    List<String> nameDaysHelper = [];

    namesWithCodes.forEach((key, value) {
      List<String> split = value.toString().split(',');
      countryCodesHelper[key] = split;
      nameDaysHelper.addAll(split);
    });

    return OneDayData(
      month: json["data"]["month"],
      day: json["data"]["day"],
      nameDays: nameDaysHelper,
      nameDaysWithCodes: countryCodesHelper,
    );
  }
}

class SearchByName {
  final int resultCount;
  final List<int> day;
  final List<int> month;
  final List<List<String>> name;
  final List<String> countryCode;
  final List<String> country;

  SearchByName(
      {required this.resultCount,
        required this.day,
        required this.month,
        required this.name,
        required this.countryCode,
        required this.country});

  factory SearchByName.fromJson(Map<String, dynamic> json) {
    List<dynamic> nameDays = json["data"]["namedays"];
    List<int> day = [];
    List<int> month = [];
    List<List<String>> name = [];
    List<String> countryCode = [];
    List<String> country = [];
    nameDays.forEach((element) {
      day.add(element["day"]);
      month.add(element["month"]);
      name.add(element["name"].toString().split(','));
      countryCode.add(element["countryCode"]);
      country.add(element["countryName"]);
    });

    return SearchByName(
      resultCount: json["data"]["resultCount"],
      day: day,
      month: month,
      name: name,
      countryCode: countryCode,
      country: country,
    );
  }
}

class SpecificDay {
  final int month;
  final int day;
  final List<String> nameDays;
  final Map<String, List<String>> nameDaysWithCodes;

  SpecificDay(
      {required this.month,
        required this.day,
        required this.nameDays,
        required this.nameDaysWithCodes});

  factory SpecificDay.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> namesWithCodes = json["data"]["namedays"];
    Map<String, List<String>> countryCodesHelper =
    new Map<String, List<String>>();
    List<String> nameDaysHelper = [];

    namesWithCodes.forEach((key, value) {
      List<String> split = value.toString().split(',');
      countryCodesHelper[key] = split;
      nameDaysHelper.addAll(split);
    });

    List<String> day = json["data"]["date"].toString().split('/');

    return SpecificDay(
      month: int.parse(day.first),
      day: int.parse(day.last),
      nameDays: nameDaysHelper,
      nameDaysWithCodes: countryCodesHelper,
    );
  }
}