import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
  int _selectedIndex = 0;
  List lstUserImages = [];
  CardController cardController = CardController();
  var _pageController = PageController();
  int _activeImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _activeImageIndex = _pageController.page!.toInt();
      });
    });
    setState(() {
      lstUsers = users;
      lstUsersLength = users.length;
    });
  }

  //METHOD TO SET STATE - BottomNavBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      onTap: _onItemTapped,
      backgroundColor: kBottomNavBarBackgroundColor,
      selectedItemColor: kBottomNavBarSelectedItemColor,
      unselectedItemColor: kBottomNavBarUnselectedItemColor,
      currentIndex: _selectedIndex,
      selectedLabelStyle: const TextStyle(
        fontSize: 18,
      ),
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
                  //swipeEdgeVertical: 2,
                  orientation: AmassOrientation.TOP,
                  swipeUp: false,
                  swipeDown: false,
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
                    child: getUserCard(index),
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
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  ClipRRect getUserCard(int index) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    lstUserImages = lstUsers[index]["imageUrl"];

    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Stack(
        children: [
          //IMAGEs
          Container(
            width: screenWidth,
            height: screenHeight,
            child: PageView(
              //physics: ClampingScrollPhysics(),
              controller: _pageController,
              children: [
                for (var image in lstUserImages)
                  // Container(
                  //   child:
                  Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                //),
              ],
              onPageChanged: (page) {
                setState(() {
                  _activeImageIndex = page;
                });
              }, //_setActiveImageIndex(),
              scrollDirection: Axis.vertical,
            ),
          ),
          //IMAGE
          // Container(
          //   width: screenWidth,
          //   height: screenHeight,
          //   child: _getImages(index),
          //   // decoration: BoxDecoration(
          //   //   image: DecorationImage(
          //   //       image: AssetImage(lstUsers[index]["imageUrl"][0]),
          //   //       fit: BoxFit.cover),
          // ),
// Indicator
          //NAME, AGE And PROFESSION

          //PAGEVIEW INDICATOR
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: RotatedBox(
              quarterTurns: 3,
              child: AnimatedSmoothIndicator(
                activeIndex: _activeImageIndex,
                count: lstUserImages.length,
                effect: CustomizableEffect(
                  activeDotDecoration: DotDecoration(
                    width: 30,
                    height: 10,
                    color: Colors.white,
                    //rotationAngle: 180,
                    //verticalOffset: 10,
                    borderRadius: BorderRadius.circular(10),
                    // dotBorder: DotBorder(
                    //   padding: 2,
                    //   width: 2,
                    //   color: Colors.indigo,
                    // ),
                  ),
                  dotDecoration: DotDecoration(
                    width: 32,
                    height: 12,
                    color: Colors.black,
                    // dotBorder: DotBorder(
                    //   padding: 2,
                    //   width: 2,
                    //   color: Colors.grey,
                    // ),
                    // borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(2),
                    //     topRight: Radius.circular(16),
                    //     bottomLeft: Radius.circular(16),
                    //     bottomRight: Radius.circular(2)),
                    borderRadius: BorderRadius.circular(16),
                    //verticalOffset: 10,
                  ),
                  spacing: 10,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                    //NAME, AGE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                    //PROFESSION
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

              const Divider(),
              //SWIPE BUTTONS
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
        ],
      ),
    );
  }
}
