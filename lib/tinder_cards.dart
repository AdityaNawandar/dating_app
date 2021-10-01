import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

import 'constants.dart';
import 'data.dart';

class TinderCards extends StatefulWidget {
  const TinderCards({Key? key}) : super(key: key);

  @override
  _TinderCardsState createState() => _TinderCardsState();
}

class _TinderCardsState extends State<TinderCards>
    with TickerProviderStateMixin {
  List lstUsers = [];
  int lstUsersLength = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      lstUsers = users;
      lstUsersLength = users.length;
    });
  }

  void updateStack(int index) {
    setState(() {
      lstUsersLength = lstUsersLength - 1;
      lstUsers.removeAt(index);
    });
  }

  CardController cardController = new CardController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //backgroundColor: Color(0xff99ebf7),
      body: getBody(),
      bottomNavigationBar: getBottomNavigationBar(),
    );
  }

  BottomNavigationBar getBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: kBottomNavBarBackgroundColor,
      selectedItemColor: Colors.black,
      currentIndex: 0,
      selectedLabelStyle: const TextStyle(fontSize: 18, color: Colors.black),
      iconSize: 32.0,
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(
            Icons.home_outlined,
            color: kBottomNavBarIconsColor,
          ),
          activeIcon: Icon(Icons.home_filled),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(
            Icons.person_outline,
            color: kBottomNavBarIconsColor,
          ),
          activeIcon: Icon(Icons.person),
        ),
        BottomNavigationBarItem(
          label: 'Messages',
          icon: Icon(
            Icons.chat_bubble_outline,
            color: kBottomNavBarIconsColor,
          ),
          activeIcon: Icon(Icons.chat_bubble),
        ),
        BottomNavigationBarItem(
          label: 'Settings',
          icon: Icon(
            Icons.settings_outlined,
            color: kBottomNavBarIconsColor,
          ),
          activeIcon: Icon(Icons.settings),
        )
      ],
    );
  }

  SizedBox getBody() {
    CardController controller; //Use this to trigger swap.
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60, top: 30),
        child: Column(
          children: [
            Flexible(
              child: Container(
                height: screenHeight,
                child: TinderSwapCard(
                  animDuration: 200,
                  swipeEdge: 8,
                  swipeEdgeVertical: 6,
                  orientation: AmassOrientation.TOP,
                  swipeUp: true,
                  totalNum: lstUsersLength,
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.height * 0.81,
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  minHeight: MediaQuery.of(context).size.height * 0.8,
                  cardBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          //blurRadius: 20,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    //COMPLETE CARD
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Stack(
                        children: [
                          //IMAGE (and Name Overlay)
                          Container(
                            width: screenWidth,
                            height: screenHeight,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage(lstUsers[index]["imageUrl"]),
                                  fit: BoxFit.cover),
                            ),
                            //NAME OVERLAY
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                //NAME AND AGE
                                Container(
                                  //alignment: Alignment.center,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    //borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            lstUsers[index]["name"] + ", ",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            lstUsers[index]["age"],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        lstUsers[index]["profession"],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),

                                // Align(
                                //   alignment: Alignment.centerRight,
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       color: Colors.white.withOpacity(0.7),
                                //       borderRadius: const BorderRadius.only(
                                //         topLeft: Radius.circular(15),
                                //         bottomLeft: Radius.circular(15),
                                //       ),
                                //     ),
                                //     //color: Colors.black.withOpacity(0.6),
                                //     height: screenHeight * 0.08,
                                //     width: screenWidth * 0.65,
                                //     //child: Center(
                                //     child: Row(
                                //       children: [
                                //         Expanded(
                                //           child: Column(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.center,
                                //             children: [
                                //               // Expanded(
                                //               Text(
                                //                 lstUsers[index]["name"],
                                //                 style: const TextStyle(
                                //                   color: Colors.black,
                                //                   fontSize: 24,
                                //                 ),
                                //                 textAlign: TextAlign.center,
                                //               ),
                                //               // ),
                                //               //Expanded(
                                //               Text(
                                //                 lstUsers[index]["profession"],
                                //                 style: const TextStyle(
                                //                   color: Colors.black,
                                //                   fontStyle: FontStyle.italic,
                                //                   fontSize: 20,
                                //                 ),
                                //                 textAlign: TextAlign.center,
                                //               ),
                                //               // ),
                                //             ],
                                //           ),
                                //         ),
                                //         Padding(
                                //           padding: const EdgeInsets.symmetric(
                                //               horizontal: 10, vertical: 0),
                                //           child: Text(
                                //             lstUsers[index]["age"],
                                //             style: const TextStyle(
                                //               color: Colors.black,
                                //               fontSize: 24,
                                //             ),
                                //             textAlign: TextAlign.center,
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //     //),
                                //   ),
                                // ),

                                const Divider(),
                                //SWIPE BUTTONS
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FloatingActionButton(
                                        child: const Icon(
                                          Icons.close_outlined,
                                          color: Colors.black,
                                          size: 32,
                                        ),
                                        backgroundColor: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            cardController.triggerLeft();
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      FloatingActionButton(
                                        child: const Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.black,
                                          size: 32,
                                        ),
                                        backgroundColor: Colors.white,
                                        onPressed: () {
                                          setState(() {
                                            cardController.triggerRight();
                                          });
                                        },
                                      ),
                                    ]),
                                const Divider(),
                              ],
                            ),
                            //),
                          ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  cardController: cardController,
                  swipeUpdateCallback:
                      (DragUpdateDetails details, Alignment align) {
                    /// Get swiping card's alignment
                    if (align.x < 0) {
                      print('LEFT');
                    } else if (align.x > 0) {
                      print('RIGHT');
                    }
                    // print(itemsTemp.length);
                  },
                  swipeCompleteCallback:
                      (CardSwipeOrientation orientation, int index) {
                    /// Get orientation & index of swiped card!

                    //if (index == (lstUsers.length - 1)) {

                    //}
                  },
                ),
                //   ],
                // ),
              ),
            ),
            Divider(),
            // Container(
            //   child: (lstUsersLength > 0)
            //       ? Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: [
            //               FloatingActionButton(
            //                 // isExtended: true,
            //                 child: Icon(Icons.undo),
            //                 backgroundColor: Colors.black,
            //                 onPressed: () {
            //                   setState(() {
            //                     //i++;
            //                   });
            //                 },
            //               ),
            //               FloatingActionButton(
            //                 // isExtended: true,
            //                 child: Icon(Icons.thumb_down_alt_outlined),
            //                 backgroundColor: Colors.black,
            //                 onPressed: () {
            //                   setState(() {
            //                     //i++;
            //                   });
            //                 },
            //               ),
            //               FloatingActionButton(
            //                 // isExtended: true,
            //                 child: Icon(Icons.thumb_up_alt_outlined),
            //                 backgroundColor: Colors.black,
            //                 onPressed: () {
            //                   setState(() {
            //                     //i++;
            //                   });
            //                 },
            //               ),
            //             ])
            //       : null,
            // )
          ],
        ),
      ),
    );
  }
}
