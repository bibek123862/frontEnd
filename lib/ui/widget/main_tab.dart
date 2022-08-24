import 'package:clothing_roll/ui/screens/cart_screen.dart';
import 'package:clothing_roll/ui/screens/about_screen.dart';
import 'package:clothing_roll/ui/screens/home_screen.dart';
import 'package:clothing_roll/ui/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';



class MainTab extends StatefulWidget {
  const MainTab({ Key? key }) : super(key: key);

  @override
  _MainTab createState() => _MainTab();
}

class _MainTab extends State<MainTab> {

  var currentIndex = 0;

  List listOfScreens = [
    HomeScreen(),
    CartScreen(),
    AboutScreen(),
    ProfileScreen(),

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
              'Shopping Mall',
              style: TextStyle(
                fontSize: 26, 
                fontFamily: 'Klavika', 
                color: Colors.blue[700])
              ),
          
          automaticallyImplyLeading: false,

    
    
          actions: [
                  Container(
                    margin: EdgeInsets.only(right: 15.0),
                    child: IconButton(
                      iconSize: 35,
                      color: Colors.blue.shade900,
                      icon: Icon(Icons.search),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        print("search icon clicked");
                      },
                      ),
                    ),
                ],
        ),
        body: listOfScreens[currentIndex],

        bottomNavigationBar: BottomNavyBar(
          backgroundColor: Colors.lightBlue.shade50,
          // itemCornerRadius: sqrt1_2,
          selectedIndex: currentIndex,
          onItemSelected: (index) {
            setState(() {
              currentIndex=index;
            });
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              activeColor: Colors.blue.shade900,
              inactiveColor: Colors.black45,
            ),


            BottomNavyBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text("My Cart"),
              activeColor: Colors.blue.shade900,
              inactiveColor: Colors.black45,
            ),


            BottomNavyBarItem(
              icon: Icon(Icons.info),
              title: Text("About"),
              activeColor: Colors.blue.shade900,
              inactiveColor: Colors.black45,
            ),


            BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              activeColor: Colors.blue.shade900,
              inactiveColor: Colors.black45,
            ),


          ],
          ),
        
    );
  }
}