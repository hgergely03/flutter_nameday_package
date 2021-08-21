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

class NameDayData {
  final int day;
  final int month;
  final List<String> name;
  final String countryCode;
  final String countryName;

  NameDayData(
      {required this.day,
      required this.month,
      required this.name,
      required this.countryCode,
      required this.countryName});

  factory NameDayData.fromJson(Map<String, dynamic> json) {
    int day = json["day"];
    int month = json["month"];
    List<String> name = json["name"].toString().split(',');
    String countryCode = json["countryCode"];
    String countryName = json["countryName"];

    return NameDayData(
        day: day,
        month: month,
        name: name,
        countryCode: countryCode,
        countryName: countryName);
  }
}

class SearchByName {
  final int resultCount;
  final List<NameDayData> results;

  SearchByName({required this.resultCount, required this.results});

  factory SearchByName.fromJson(Map<String, dynamic> json) {
    List<dynamic> nameDays = json["data"]["namedays"];
    int resultCount = json["data"]["resultCount"];
    List<NameDayData> nameDaysData = [];

    nameDays.forEach((element) {
      nameDaysData.add(NameDayData.fromJson(element));
    });

    return SearchByName(
      resultCount: resultCount,
      results: nameDaysData,
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
