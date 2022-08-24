import 'dart:async';
import 'package:clothing_roll/ui/screens/auth/login.dart';
import 'package:clothing_roll/ui/widget/main_tab.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  var finalToken = "";

  @override
  void initState() {
    getValidateData().whenComplete(() async {
      if (finalToken == "null") {
        Timer(Duration(seconds: 2),
            () => Navigator.of(context).push(MaterialPageRoute(builder:  (context)=>loginPage())));
      }
      else{
        Timer(Duration(seconds: 2),
            () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MainTab())));
      }
    });
      
    super.initState();
  }

  Future getValidateData() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainedToken = sharedPreferences.getString("token")?? "null";
    setState(() {
      finalToken = obtainedToken;
    });
    print( "hey $finalToken" );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("images/logo/logo.png")),
          ],
        ),
      )
    );
  }
}


// AnimatedSplashScreen(
//             duration: 1000,
//             splash: Container(
//             child: Image(image: AssetImage("images/logo/logo.png")),
//               ),
//             nextScreen: loginPage(),
//             splashTransition: SplashTransition.rotationTransition,
//             backgroundColor: Colors.white
//             ),