import 'package:clothing_roll/http/httpUser.dart';
import 'package:clothing_roll/model/userModel.dart';
import 'package:clothing_roll/ui/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';


class registerPage extends StatefulWidget {
  const registerPage({ Key? key }) : super(key: key);

  @override
  _registerPage createState() => _registerPage();
}

class _registerPage extends State<registerPage> {

  // String username = "";
  // String email = "";
  // String password = "";

  TextEditingController _usernameControler = TextEditingController();
  TextEditingController _emailControler = TextEditingController();
  TextEditingController _passwordControler = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<bool> registerUserForm(User u) {
      var res = HttpConnectUser().registerUser(u);
      return res;
    }
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context)
            .pop();
          },
          ),
        title: Text(
              'Register',
              style: TextStyle(
                fontSize: 26, 
                fontFamily: 'Klavika', 
                color: Colors.blue[700])
              ),

        ),
        body: ListView(
          children: [
            Center(
              child: Column(
                children: [


                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 5),
                    child: ClipRRect(
                              borderRadius: BorderRadius.all(
                              Radius.circular(100)
                            ),
                          child: Image(
                            height: 130,
                            image: AssetImage('images/logo/register.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                  ),


                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      "Register", 
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
                              key: const Key("run"),
                              controller: _usernameControler,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                              ),
                              validator: (value){
                                if (value!.isEmpty) {
                                  return "required username";
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
                              key: const Key("re"),
                              controller: _emailControler,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                              ),
                              validator:MultiValidator([
                                RequiredValidator(errorText: "required email"),
                                EmailValidator(errorText: "email not validate")

                              ])
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              key: const Key("rpw"),
                              controller: _passwordControler,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                              validator: MultiValidator([
                                RequiredValidator(errorText: "required password"),
                                MinLengthValidator(8, errorText: "required minimum 8 characher")
                              ])
                            ),
                          ),

                          Container(
                            height: 50,
                            margin: EdgeInsets.all(20),
                            width: 400,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              key: const Key("rrb"),
                              child: const Text('Register', style: TextStyle(fontSize: 20),),
                              onPressed: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  User u =  User(
                                    username: _usernameControler.text,
                                    email: _emailControler.text,
                                    password: _passwordControler.text
                                  );
                                  print(u);


                                  bool isCreated = await registerUserForm(u); 
                                  if (isCreated) {
                                    Navigator.of(context)
                                      .push(MaterialPageRoute(
                                      builder: (context)=>loginPage()
                                    ));
                                    MotionToast.success(description: Text("Your account has been created")).show(context);
                                  } else {
                                    MotionToast.error(description: Text('Failed to create user'))
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
                    const Text('Already have account?'),
                    TextButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                        .pop();
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