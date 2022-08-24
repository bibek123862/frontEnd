import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:clothing_roll/constants/constants.dart';
import 'package:clothing_roll/model/userModel.dart';
import 'package:clothing_roll/response/user_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpConnectUser {
  // static String token = '';
  var log = Logger();


    Future<String> uploadImage(String filepath) async {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString("token")?? "null";
      String tok = 'Bearer $token';
      try {
          String url = imageURL;
          var request = MultipartRequest('PUT', Uri.parse(url));
          //using the token in the headers
          request.headers.addAll({
            'Authorization': tok,
          });

          // need a filename
            var ss = filepath.split('/').last;
            // adding the file in the request
            request.files.add(
              MultipartFile(
                'file',
                File(filepath).readAsBytes().asStream(),
                File(filepath).lengthSync(),
                filename: ss,
              ),
            );

          var response = await request.send();
          var responseString = await response.stream.bytesToString();
          if (response.statusCode == 200) {
            return 'ok';
          }
        } catch (err) {
          log.i('$err');
        }
      return 'something goes wrong';
    }





  //sending data to the server--- creating user
  Future<bool> registerUser(User user) async {
    try {
        Map<String, dynamic> userMap = {
        "username": user.username,
        "email": user.email,
        "password": user.password,
        };

      final response =
          await post(Uri.parse(USER_REGISTER_URL), body: userMap);
      log.i(response.body);
      log.i(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var userResponse = ResponseUser.fromJson(jsonDecode(response.body));
        log.i(userResponse);
        return userResponse.success!;
      } else {
        log.i("server error");
        return Future.error("server errorrrrrrrrrrrrrrrrrrrrrrr");
      }
    } catch (e) {
      log.i("connecyion error");
      Future.error("errrrrrrrooooorrr $e");
    }
    return false;
  }

  //sending data to the server- login as user
  Future<bool> loginUser(String username, String password) async {
    Map<String, dynamic> loginUser = {
      'username': username,
      'password': password
    };

    try {
      final response = await post(
          Uri.parse(
            USER_LOGIN_URL,
          ),
          body: loginUser);
      log.i(response.body);
      log.i(response.statusCode);
      //json serializing inline
      final jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        tokenConstant = jsonData['token'];
        var loginResponse = ResponseUser.fromJson(jsonData);
        log.i(loginResponse.success);
        return loginResponse.success!;
      } else {
        log.i("server error");
        return Future.error("server errorrrrrrrrrrrrrrrrrrrrrrr");
      }
    } catch (e) {
      print(e);
    }
    return false;
  }






 Future<ResponseUserProfile<User>> userProfile() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token")?? "null";
    String tok = 'Bearer $token';
    try {
      final response = await get(Uri.parse(USER_POFILE_URL), headers: {
        'Authorization': tok
      });
      log.i(" detail response ${response.body}");
      log.i(response.statusCode);
      if (response.statusCode==200) {
        final jsonData = jsonDecode(response.body);
        log.i(jsonData);
        var u = ResponseUserProfile<User>(data: User.fromJson(jsonData));
        log.i(u);
        return u;
      }
      else{
        throw Exception("Failed to load user profile");
      }
      
    } catch (e) {
      log.i("connection error");
      Future.error("errrrrrrrooooorrr $e");
    }
    return throw Exception("Failed to connect server");

    
  }




  Future<bool> userProfileUpdate(User user, File? file) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token")?? "null";
    String tok = 'Bearer $token';
    String s = '';
    try {
        Map<String, dynamic> userProfileMap = {
        "username": user.username,
        "email": user.email,
        "firstName": user.firstName,
        "lastName": user.lastName,
        "address": user.address,
        // "profilePicture":user.profilePicture,
        };

      final response =
          await put(Uri.parse(USER_PROFILE_UPDATE_URL), headers: {
             'Authorization': tok
          }, body: userProfileMap);
      log.i(response.body);
      log.i(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {

        if (file != null) {
          var jsonData = jsonDecode(response.body);
          s = await uploadImage(file.path);
        }
        if (s == 'ok') {
          MotionToast.success(description: Text("Data uploaded successfully"));
        }

        var userResponse = ResponseUser.fromJson(jsonDecode(response.body));
        log.i(userResponse);
        return userResponse.success!;
        
      } else {
        log.i("server error");
        return Future.error("server errorrrrrrrrrrrrrrrrrrrrrrr");
      }
    } catch (e) {
      log.i("connecyion error");
      Future.error("errrrrrrrooooorrr $e");
    }
    return false;
  }








}
