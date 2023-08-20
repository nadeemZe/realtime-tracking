import 'package:flutter/material.dart';
import 'package:tracking_map/tracking_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter tracking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TrackingPage(),
    );
  }
}
