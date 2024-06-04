import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task1/controller/weather_controller.dart';
import 'package:task1/models/wheather.dart';
import 'package:task1/repository/weather_api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _weatherController = WeatherController(WeatherRepository());
  late Future<WeatherData> _weatherData;

  @override
  void initState() {
    super.initState();
    _weatherData = _weatherController.getWeatherForCity('London');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://i.pinimg.com/564x/19/4d/44/194d442221bc017907db89d1ea4dd152.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<WeatherData>(
          future: _weatherData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final weather = snapshot.data!;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Gap(16.0),
                    Text(
                      'Weather',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter city name',
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          label: Text(
                            'City name',
                            style: TextStyle(color: Colors.white),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            _weatherData = _weatherController
                                .getWeatherForCity(value.toLowerCase());
                          });
                        },
                      ),
                    ),
                    Gap(16.0),
                    Text(
                      '${weather.city}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${weather.temperature.ceil()}°C',
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weather.description,
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                          ),
                        ),
                        Image.network(
                          'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                          width: 64.0,
                          height: 64.0,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
