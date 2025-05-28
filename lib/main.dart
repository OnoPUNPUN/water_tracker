import 'package:flutter/material.dart';
import 'package:water_tracker/pages/water_tracker_page.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Tracker',
      debugShowCheckedModeBanner: false,
      home: WaterTrackerPage(),
    );
  }
}
