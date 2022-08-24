import 'package:clothing_roll/constants/constants.dart';
import 'package:clothing_roll/http/httpUser.dart';
import 'package:clothing_roll/ui/screens/auth/register.dart';
import 'package:clothing_roll/ui/widget/main_tab.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginPage extends StatefulWidget {
  const loginPage({ Key? key }) : super(key: key);

  @override
  _loginPage createState() => _loginPage();
}

class _loginPage extends State<loginPage> {

  TextEditingController _usernameControler = TextEditingController();
  TextEditingController _passwordControler = TextEditingController();

  var log = Logger();

  final _formKey = GlobalKey<FormState>();

  Future<bool> loginPost(String uname, String pass) {
    var res = HttpConnectUser().loginUser(uname, pass);
    return res;
  }



  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
        body: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  

                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 20),
                    child: ClipRRect(
                              borderRadius: BorderRadius.all(
                              Radius.circular(100)
                            ),
                          child: Image(
                            height: 150,
                            image: AssetImage('images/logo/power.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                  ),

                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Login", 
                      style: TextStyle(
                        color: Colors.teal, 
                        fontSize: 40, 
                        fontWeight: FontWeight.bold),
                      ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              key: const Key("lun"),
                              controller: _usernameControler,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                              ),
                              validator: (value){
                                if (value!.isEmpty) {
                                  return "Required";
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              key: const Key("lpass"),
                              controller: _passwordControler,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                              validator: (value){
                                if (value!.isEmpty) {
                                  return "Required";
                                }
                                else{
                                  return null;
                                }
                              },
                            ),
                          ),

                          Container(
                            height: 50,
                            margin: EdgeInsets.all(20),
                            width: 400,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              key: const Key("llb"),
                              child: const Text('Login', style: TextStyle(fontSize: 20),),
                              onPressed: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  
                                  var res = await loginPost(_usernameControler.text, _passwordControler.text);
                                   if (res) {
                                     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                     sharedPreferences.setString("token", tokenConstant);
                                        Navigator.of(context)
                                        .push(MaterialPageRoute(
                                          builder: (context)=>MainTab()
                                          
                                        ));
                                        MotionToast.success(
                                          description: Text('Login Successfull') ,
                                          toastDuration: const Duration(seconds: 1),
                                        ).show(context);
                                 
                                  } else {
                                    MotionToast.error(description: Text('Login UnSuccessfull'))
                                        .show(context);
                                  }
                                }
                                else{
                                  print("validation error");
                                }
                              },
                            )
                        ),

                        ],
                      )
                      ),
                  ),

                    

                  Row(
                  children: <Widget>[
                    const Text('Does not have account?'),
                    TextButton(
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                        .push(MaterialPageRoute(
                          builder: (context)=>registerPage()
                          ));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),

                ],
              ),
            )
          ],
        ),
    );
  
  }
}