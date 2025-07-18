class WeatherData {
  final String cityName;
  final List <DailyData> forecastdays;
  WeatherData({
   required this.cityName,
   required this.forecastdays
});
  factory WeatherData.fromJson(Map<String, dynamic> json){
    return WeatherData(
        cityName: json['location']['name'],
        forecastdays: (json['forecast']['forecastday'] as List)
        .map((day) => DailyData.fromJson(day)).toList()
    );
  }
}

class DailyData {
  final DateTime date;
  final double maxTemp;
  final double minTemp;
  final String condition;
  final String icon;

  DailyData({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.icon
});

  factory DailyData.fromJson(Map<String, dynamic> json){
    return DailyData(
        date: DateTime.parse(json['date']),
        maxTemp: json['day']['maxtemp_c'].toDouble(),
        minTemp: json['day']['mintemp_c'].toDouble(),
        condition: json['day']['condition']['text'],
        icon: "https:${json['day']['condition']['icon']}"
    );
  }
}