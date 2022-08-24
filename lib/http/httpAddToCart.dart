import 'dart:convert';
import 'package:clothing_roll/constants/constants.dart';
import 'package:clothing_roll/model/addToCartModel.dart';
import 'package:clothing_roll/response/addToCart_response.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HttpAddToCart {
  var log = Logger();

  

  //sending data to the server--- creating user
  Future<bool> addToCart(AddToCart addToCart, id) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token")?? "null";
    String tok = 'Bearer $token';
    log.i("my token add to cart $tok");
    try {
        Map<String, dynamic> userMap = {
        "productQuantity": addToCart.productQuantity,
        };

      final response =
          await post(Uri.parse(ADD_TO_CART+id), headers: {'Authorization': tok}, body: userMap);
      log.i(response.body);
      log.i(response.statusCode);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        var addToCartResponse = AddToCartResponse.fromJson(jsonDecode(response.body));
        log.i(addToCartResponse);
        return addToCartResponse.success!;
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




  Future<List<AddToCart>> getCartItem() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token")?? "null";
    String tok = 'Bearer $token';
    try {
      final response = await get(Uri.parse(My_CART), headers: {'Authorization': tok});
      log.i(response.body);
      log.i(response.statusCode);
      if (response.statusCode==200) {
          log.i(response.body);
          var myCartItems = CartListResponse.fromJson(jsonDecode(response.body));
          return myCartItems.data;
      }
      else{
        throw Exception("Failed to load cart items");
      }
      
    } catch (e) {
      
      Future.error("errrrrrrrooooorrr $e");
    }
    return throw Exception("Failed to connect server");

    
  }



  Future<bool> deleteCartItem(id) async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token")?? "null";
    String tok = 'Bearer $token';
    try {
      final response = await delete(Uri.parse(DELETE_MY_CART + id ), headers: {'Authorization': tok});
      log.i(response.body);
      log.i(response.statusCode);
      if (response.statusCode==200) {
          log.i(response.body);
          var myCartItems = AddToCartResponse.fromJson(jsonDecode(response.body));
          return myCartItems.success!;
      }
      else{
        throw Exception("Failed to load cart items");
      }
      
    } catch (e) {
      
      Future.error("errrrrrrrooooorrr $e");
    }
    return throw Exception("Failed to connect server");

    
  }














}
