import 'package:flutter/material.dart';

import 'cosmic_instant_page.dart';

class CosmicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosmic Instant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CosmicInstantPage(title: 'Cosmic Instant'),
    );
  }
}