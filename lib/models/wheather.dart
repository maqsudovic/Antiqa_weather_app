class WeatherData {
  final double temperature;
  final String description;
  final String city;
  final String icon;

  WeatherData({
    required this.temperature,
    required this.description,
    required this.city,
    required this.icon
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      icon: json['weather'][0]['icon'],
      temperature: json['main']['temp'],
      description: json['weather'][0]['description'],
      city: json['name'],
    );
  }
}