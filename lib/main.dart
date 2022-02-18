import 'package:flutter/material.dart';
import 'package:tap_game/game_over.dart';
import 'package:tap_game/tap_game.dart';

import 'game_start.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(),
        primarySwatch: Colors.blue,
      ),
      home: const GameStart(),
    );
  }
}
