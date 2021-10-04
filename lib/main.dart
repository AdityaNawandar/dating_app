import 'package:dating_app/tinder_cards.dart';
import 'package:flutter/material.dart';

import 'landing.dart';
import 'size_config.dart';

void main() {
  runApp(const Talaash());
}

class Talaash extends StatelessWidget {
  const Talaash({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Nautilus',
        //fontFamily: 'blowbrush',
      ),
      //home: const SwipeCardsClass(),
      //home: const TinderCards(),
      home: LandingScreen(),
      routes: {
        //'/': (context) => LandingScreen(),
        TinderCards.routeName: (context) => TinderCards(),
      },
    );
  }
}
