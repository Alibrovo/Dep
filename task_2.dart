import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String apiKey = 'YOUR_API_KEY';
  String city = 'London';
  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey'));
    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Weather'),
      ),
      body: weatherData == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Text(
                  weatherData!['name'],
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  '${(weatherData!['main']['temp'] - 273.15).toStringAsFixed(1)} °C',
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  weatherData!['weather'][0]['description'],
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_screen.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter city name'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(city: _controller.text),
                  ),
                );
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class WeatherAlertsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data for alerts
    final alerts = [
      'Heavy rain expected tomorrow',
      'Thunderstorm warning in your area',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Alerts'),
      ),
      body: ListView.builder(
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(alerts[index]),
          );
        },
      ),
    );
  }
}