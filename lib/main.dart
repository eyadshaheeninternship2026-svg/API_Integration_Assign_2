import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CountryScreen(),
    );
  }
}

class CountryScreen extends StatefulWidget {
  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {

  String country = "";
  String capital = "";

  Future<void> fetchCountry() async {

    final response = await http.get(
      Uri.parse('https://restcountries.com/v3.1/name/palestine'),
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      setState(() {
        country = data[0]['name']['common'];
        capital = data[0]['capital'][0];
      });

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("API 123"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              onPressed: fetchCountry,
              child: const Text("Get Country Data"),
            ),

            const SizedBox(height: 20),

            Text(
              "Country: $country",
              style: const TextStyle(fontSize: 22),
            ),

            Text(
              "Capital: $capital",
              style: const TextStyle(fontSize: 22),
            ),

          ],
        ),
      ),
    );
  }
}