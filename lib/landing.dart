import 'package:dating_app/tinder_cards.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'shared/button.dart';
//import 'shared/default_button_transparent.dart';
import 'size_config.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      appBar: null,
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SizedBox(
        //height: screenHeight,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //APP NAME
              const Flexible(
                child: Text(
                  kAppName,
                  style: TextStyle(
                      color: kAppNameColor,
                      fontSize: 40,
                      //fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              //IMAGE
              Container(
                color: Colors.white,
                height: getProportionateScreenHeight(300),
                child: Image.asset(
                  kLandingImage,
                  fit: BoxFit.cover,
                ),
              ),

              //TAG LINE
              const Flexible(
                child: Text(
                  kTagLine,
                  style: TextStyle(
                      //color: kAppNameColor,
                      fontSize: 26,
                      //fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),

              const Divider(
                color: Colors.transparent,
                height: 175,
              ),
              //REGISTER
              Flexible(
                child: DefaultButton(
                  buttonText: kRegisterButtonText,
                  onPress: () {
                    print("");
                  },
                ),
              ),
              const Divider(color: Colors.transparent),
              //LOGIN
              Flexible(
                child: DefaultButtonTransparent(
                  buttonText: kLoginButtonText,
                  onPress: () {
                    Navigator.of(context).pushNamed(TinderCards.routeName);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
