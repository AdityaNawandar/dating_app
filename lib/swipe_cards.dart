import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

import 'content.dart';

class SwipeCardsClass extends StatefulWidget {
  const SwipeCardsClass({Key? key}) : super(key: key);

  final String title = "";

  @override
  _SwipeCardsState createState() => _SwipeCardsState();
}

class _SwipeCardsState extends State<SwipeCardsClass> {
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final List<String> _names = ["Red", "Blue", "Green", "Yellow", "Orange"];
  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange
  ];
  final List<String> _images = [
    'assets/images/anastasia-vityukova-unsplash.jpg',
    'assets/images/brock-wegner-unsplash.jpg',
    'assets/images/good-faces-hiba-unsplash.jpg',
    'assets/images/houcine-ncib-unsplash.jpg',
    'assets/images/morteza-solgi-unsplash.jpg',
    'assets/images/poonam-dhiman-unsplash.jpg',
    'assets/images/seth-doyle-unsplash.jpg',
  ];

  @override
  void initState() {
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(
        SwipeItem(
            content: Content(text: _names[i], color: _colors[i]),
            likeAction: () {
              _scaffoldKey.currentState?.showSnackBar(
                SnackBar(
                  content: Text("Liked ${_names[i]}"),
                  duration: const Duration(milliseconds: 500),
                ),
              );
            },
            nopeAction: () {
              _scaffoldKey.currentState?.showSnackBar(
                SnackBar(
                  content: Text("Nope ${_names[i]}"),
                  duration: const Duration(milliseconds: 500),
                ),
              );
            },
            superlikeAction: () {
              _scaffoldKey.currentState?.showSnackBar(
                SnackBar(
                  content: Text("Superliked ${_names[i]}"),
                  duration: const Duration(milliseconds: 500),
                ),
              );
            }),
      );
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Swipe Cards'),
      ),
      body: Container(
        child: Column(children: [
          Container(
            height: 550,
            child: SwipeCards(
              matchEngine: _matchEngine,
              itemBuilder: (BuildContext context, int index) {
                return
                    //------------------------------------------------------------------------------
                    ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5,
                      sigmaY: 5,
                    ),
                    // child: Card(
                    //   //color: Colors.white.withOpacity(0.3),
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    child: Center(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        color: Colors.white30,
                        child: Image.asset(
                          _images[index],
                          height: 400,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                        // child: Text(
                        //   _swipeItems[index].content.text,
                        //   style: const TextStyle(fontSize: 100),
                        // ),
                      ),
                    ),
                    //),
                  ),
                );

                //-----------------------------------------------------------------------------------
              },
              onStackFinished: () {
                _scaffoldKey.currentState?.showSnackBar(SnackBar(
                  content: Text("Stack Finished"),
                  duration: Duration(milliseconds: 500),
                ));
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _matchEngine.currentItem?.nope();
                  },
                  child: Text("Nope")),
              ElevatedButton(
                  onPressed: () {
                    _matchEngine.currentItem?.superLike();
                  },
                  child: Text("Superlike")),
              ElevatedButton(
                  onPressed: () {
                    _matchEngine.currentItem?.like();
                  },
                  child: Text("Like"))
            ],
          )
        ]),
      ),
    );
  }
}
