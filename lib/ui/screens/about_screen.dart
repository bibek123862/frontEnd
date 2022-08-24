import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({ Key? key }) : super(key: key);

  @override
  _AboutScreen createState() => _AboutScreen();
}

class _AboutScreen extends State<AboutScreen> {

  

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(15.0),

      child: Column(
        children: [
          
          Text(
            "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available\n\nIn publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available\n\nIn publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available",
            style: TextStyle(fontSize: 15, color: Colors.black54, fontFamily: 'openSans', ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 10),
          ),

          Divider(
            thickness: 0.5,
            color: Colors.black26,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Text("\u00a9 clothing roll design & developed by ajjan gurung"),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Privacy Policy ",
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()..onTap=lunchWebsite,
                ),
                TextSpan(
                  text: "& ",
                  style: TextStyle(color: Colors.black),
                ),

                TextSpan(
                  text: "Terms & Conditions ",
                  style: TextStyle(color: Colors.blue),
                ),

              ]
            )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Follow Us", style: TextStyle(decoration: TextDecoration.underline),),
          ),
          Wrap(
            spacing: 10,
            children: [
              IconButton(
                onPressed: () async {
                  String url = "https://www.facebook.com/";
                  if (await canLaunch(url)) {
                    await launch(
                    url,
                    forceWebView: true,
                    enableDomStorage: true,
                    enableJavaScript: true,
                    // webOnlyWindowName: '_self'
                    );
                  }
                  else{
                    print("the action is not supported");
                  }
                  
                }, 
                icon: Icon(FontAwesomeIcons.facebook),
                color: Colors.blue,
              ),

              IconButton(
                onPressed: () async {
                  String url = "https://www.instgram.com/";
                  if (await canLaunch(url)) {
                    await launch(
                    url,
                    forceWebView: true,
                    enableDomStorage: true,
                    enableJavaScript: true,
                    // webOnlyWindowName: '_self'
                    );
                  }
                  else{
                    print("the action is not supported");
                  }
                  
                }, 
                icon: Icon(FontAwesomeIcons.instagram, color: Colors.redAccent),
                color: Colors.blue,
              ),

              IconButton(
                onPressed: () async {
                  String url = "https://www.toktok.com/";
                  if (await canLaunch(url)) {
                    await launch(
                    url,
                    // forceWebView: true,
                    // enableDomStorage: true,
                    // enableJavaScript: true,
                    // webOnlyWindowName: '_self'
                    );
                  }
                  else{
                    print("the action is not supported");
                  }
                  
                }, 
                icon: Icon(FontAwesomeIcons.tiktok, color: Colors.black,),
              ),
            ],
          )
          

          
        ],
      )
      
    );


    

    
  }

  Future lunchWebsite() async {
      const url = "https://flutter.dev";
      await launch(
        url,
        forceWebView: true,
        enableDomStorage: true,
        enableJavaScript: true,
        webOnlyWindowName: '_self'
        );
    }
}