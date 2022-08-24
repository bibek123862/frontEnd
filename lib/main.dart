import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:clothing_roll/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'dart:async';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restart_app/restart_app.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize('resource://drawable/logo', // icon for your app notification
      [
        NotificationChannel(
            channelKey: 'key1',
            channelName: 'Cloting Roll',
            channelDescription: "Online Cloth Store",
            defaultColor: const Color(0XFF9050DD),
            ledColor: Colors.white,
            playSound: true,
            enableLights: true,
            importance: NotificationImportance.High,
            enableVibration: true)
      ]);
  runApp(const MyApp());
}





class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  var log = Logger();
  bool _isNear = false;
  late StreamSubscription<dynamic> _streamSubscription;

    @override
  void initState() {
    super.initState();
    listenSensor();
  }

    @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }


   Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };
    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0 || event < 8) ? true : false;
        if (_isNear==true) {
         logout();
        }
      });
    });
  }


  Future logout() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.remove("token");
     Restart.restartApp();
  
  }



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clothing Roll',
      theme: ThemeData(
        primaryColor: Color(0xffEEEDEE),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}


