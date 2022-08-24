import 'dart:convert';
import 'package:clothing_roll/constants/constants.dart';
import 'package:clothing_roll/model/productModel.dart';
import 'package:clothing_roll/response/product_response.dart';
import 'package:clothing_roll/sqfliteDatabase/db_provider.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class HttpProduct {
  var log = Logger();

  Future<List<Product>> getProducts() async{
    try {
      final response = await get(Uri.parse(GET_ALL_PRODUCTS));
      print(GET_ALL_PRODUCTS);
      log.i(response.body);
      log.i(response.statusCode);
      if (response.statusCode==200) {
        var allProducts = ResponseProduct.fromJson(jsonDecode(response.body));
        log.i(allProducts.data);
        var s = allProducts.data;
        s.map((e){
          DBProvider.db.createProduct(Product.fromJson(e.toJson()));
        });
        log.i(s);
        log.i(s.length);

        // DBProvider.db.createProduct(Product.fromJson(allProducts.data)).toJson();
        
        return (allProducts.data);
      }
      else{
        throw Exception("Failed to load products");
      }
      
    } catch (e) {
      log.i("connecyion error");
      Future.error("errrrrrrrooooorrr $e");
    }
    return throw Exception("Failed to connect server");

    
  }
 

 Future<ResponseProductDetail<Product>> getSingleProducts(id) async{
    try {
      final response = await get(Uri.parse(GET_SINGLE_PRODUCTS+id));
      print("response of detail $response");
      log.i(" detail response ${response.body}");
      log.i(response.statusCode);
      if (response.statusCode==200) {
        final jsonData = jsonDecode(response.body);
        log.i(jsonData);
        var s = ResponseProductDetail<Product>(data: Product.fromJson(jsonData));
        log.i(s);
        return s;
        // return singleProduct<Product>;
      }
      else{
        throw Exception("Failed to load single product");
      }
      
    } catch (e) {
      log.i("connection error");
      Future.error("errrrrrrrooooorrr $e");
    }
    return throw Exception("Failed to connect server");

    
  }

  

}

  

