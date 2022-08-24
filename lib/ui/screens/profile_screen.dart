import 'package:clothing_roll/ui/screens/auth/login.dart';
import 'package:clothing_roll/ui/screens/auth/updateProfile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
            // ListTile(
            //       leading: CircleAvatar(
            //         backgroundImage:AssetImage("images/c.jpeg")
            //       ),
            //       title: Text("Preeti", style: TextStyle(fontSize: 18)),
            //       subtitle: Text(
            //         'view your profile',
            //         style: TextStyle(fontSize: 13)
            //         ),
            //       onTap: () => {
                      
            //         },
                
            //     ),

            ListTile(
                  leading: Icon(Icons.update),
                  title: Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 14),
                    ),
                    onTap: () {
                      Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => updateProfile()
                      ));
                    },
                ),
                
            Divider(
                  thickness: 1,
                  color: Colors.black12,
                ),

            ListTile(
                  leading: Icon(Icons.logout_outlined),
                  title: Text(
                    "Logout",
                    style: TextStyle(fontSize: 14),
                    ),
                    onTap: () async {
                      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                      sharedPreferences.remove("token");
                      Navigator.of(context)
                        .push(MaterialPageRoute(
                        builder: (context)=>loginPage()
                      ));
                    },
                ),

                Divider(
                  thickness: 1,
                  color: Colors.black12,
                ),


        ],
      ),
    );
  }
}