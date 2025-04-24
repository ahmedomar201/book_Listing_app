class WeatherModel {
  List<Weather>? weather;
  Main? main;
  Wind? wind;
  int? id;
  String? name;

  WeatherModel({this.weather, this.main, this.wind, this.id, this.name});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }

    main = json['main'] != null ? Main.fromJson(json['main']) : null;

    wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;

    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }

    if (main != null) {
      data['main'] = main!.toJson();
    }

    if (wind != null) {
      data['wind'] = wind!.toJson();
    }

    data['id'] = id;
    data['name'] = name;

    return data;
  }
}

class Weather {
  int? id;
  String? main;

  Weather({this.id, this.main});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;

    return data;
  }
}

class Main {
  double? temp;

  int? humidity;

  Main({this.temp, this.humidity});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];

    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;

    data['humidity'] = humidity;

    return data;
  }
}

class Wind {
  double? speed;

  Wind({this.speed});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;

    return data;
  }
}
