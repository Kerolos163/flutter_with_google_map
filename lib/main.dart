import 'package:flutter/material.dart';
import 'package:flutter_with_google_map/widgets/custom_google_map.dart';

void main() {
  runApp(const TestGoogleMapWithFlutter());
}

class TestGoogleMapWithFlutter extends StatelessWidget {
  const TestGoogleMapWithFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomGoogleMap(),
    );
  }
}
