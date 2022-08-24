import 'dart:io';

import 'package:clothing_roll/constants/constants.dart';
import 'package:clothing_roll/http/httpUser.dart';
import 'package:clothing_roll/model/userModel.dart';
import 'package:clothing_roll/ui/screens/auth/register.dart';
import 'package:clothing_roll/ui/widget/main_tab.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class updateProfile extends StatefulWidget {
  const updateProfile({ Key? key }) : super(key: key);

  @override
  _updateProfile createState() => _updateProfile();
}

class _updateProfile extends State<updateProfile> {

  TextEditingController _usernameControler = TextEditingController();
  TextEditingController _emailControler = TextEditingController();
  TextEditingController _firstNameControler = TextEditingController();
  TextEditingController _lastNameControler = TextEditingController();
  TextEditingController _addressControler = TextEditingController();
  String photourl = 'http://10.0.2.2:8000/';
  String profile = "";
  String username = "";

  var log = Logger();

  final _formKey = GlobalKey<FormState>();
  File? _image;



  Future<bool> updateProfileForm(User u, image) {
      var res = HttpConnectUser().userProfileUpdate(u, image);
      return res;
    }


  @override
  void initState() {
    super.initState();
    _image = null;

    HttpConnectUser().userProfile()
    .then((value){
      setState(() {

         log.i(" my value $value");
          _usernameControler.text = value.data!.username.toString();
          _emailControler.text = value.data!.email.toString();
          _firstNameControler.text = value.data!.firstName.toString();
          _lastNameControler.text = value.data!.lastName.toString();
          _addressControler.text = value.data!.address.toString();
          profile = value.data!.profilePicture.toString();
          username = value.data!.username!.toString();
          log.i(profile);
          
      });
     
    });



  }



    //method to open image from gallery
  _imageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  //method to open image from camera
  _imageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }





  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
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
              'Profile',
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

                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _image == null
                              ? const AssetImage('images/logo/profile.png')
                                  as ImageProvider
                              : FileImage(_image!),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (builder) => bottomSheet());
                            },
                            child: const Icon(
                              Icons.upload,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ),
                      ),


                      // Padding(
                      //   padding: const EdgeInsets.only(top: 30, bottom: 20),
                      //   child: ClipRRect(
                      //             borderRadius: BorderRadius.all(
                      //             Radius.circular(100)
                      //           ),
                      //         child: Image(
                      //           height: 150,
                      //           image: NetworkImage(photourl+profile),
                      //           fit: BoxFit.cover,
                      //         ),
                              
                      //       ),
                      // ),


                    ],
                  ),
                  

                  

                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "$username", 
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
                              controller: _firstNameControler,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'First Name',
                              ),
                              validator:MultiValidator([
                                RequiredValidator(errorText: "required first name"),

                              ])
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _lastNameControler,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Last Name',
                              ),
                              validator:MultiValidator([
                                RequiredValidator(errorText: "required Last Name"),
                              ])
                            ),
                          ),

                           Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _addressControler,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Address',
                              ),
                              validator:MultiValidator([
                                RequiredValidator(errorText: "required address"),
                              ])
                            ),
                          ),


                          Container(
                            height: 50,
                            margin: EdgeInsets.all(20),
                            width: 400,
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              child: const Text('Save', style: TextStyle(fontSize: 20),),
                              onPressed: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();


                                   User u =  User(
                                    username: _usernameControler.text,
                                    email: _emailControler.text,
                                    firstName: _firstNameControler.text,
                                    lastName: _lastNameControler.text,
                                    address: _addressControler.text,
                                  );
                                  print(u);

                                  // HttpConnectUser().userProfileUpdate(u, _image);


                                  bool isCreated = await updateProfileForm(u, _image); 
                                  if (isCreated) {
                                    Navigator.of(context).pop();
                                    MotionToast.success(description: Text("Your account has been updated")).show(context);
                                  } else {
                                    MotionToast.error(description: Text('Failed to updating profile'))
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
                ],
              ),
            )
          ],
        ),
    );
  
  }



//widget to build a bottomsheet for image

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text(
            'Choose profile photo',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _imageFromCamera();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _imageFromGallery();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.image),
                label: const Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }



}