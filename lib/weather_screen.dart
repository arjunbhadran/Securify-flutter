import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _cityName = 'Kochi';
  String _weatherDescription = '';
  double _temperature = 0;

  Future<void> _fetchWeatherData() async {
    final apiKey = 'bf3a41970213d71064808ac071a9d173';
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$_cityName&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(apiUrl));
    final jsonData = json.decode(response.body);

    setState(() {
      _weatherDescription = jsonData['weather'][0]['description'];
      _temperature = jsonData['main']['temp'];
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Color _getBackgroundColor() {
    if (_weatherDescription.toLowerCase().contains('rain')) {
      return Colors.blueGrey[400]!;
    } else if (_weatherDescription.toLowerCase().contains('cloud')) {
      return Colors.grey[400]!;
    } else {
      return Colors.orange[300]!;
    }
  }

  Color _getTextColor() {
    if (_weatherDescription.toLowerCase().contains('rain') ||
        _weatherDescription.toLowerCase().contains('cloud')) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
      ),
      body: Container(
        color: _getBackgroundColor(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'City: $_cityName',
                style: TextStyle(fontSize: 20, color: _getTextColor()),
              ),
              SizedBox(height: 10),
              Text(
                'Temperature: $_temperature°C',
                style: TextStyle(fontSize: 20, color: _getTextColor()),
              ),
              SizedBox(height: 10),
              Text(
                'Weather: $_weatherDescription',
                style: TextStyle(fontSize: 20, color: _getTextColor()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}