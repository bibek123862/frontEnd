import 'package:clothing_roll/model/productModel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Product Test", () {
    test('test 1',() async {

      List<Map<String, dynamic>> product = [
        {
          "_id": "5349b4ddd2781d08c09890f3",
          "productName": "Man Tshirt",
          "productDisplayPrice": 20.0,
          "productActualPrice": 15.0,
          "productDesc": "all brands of tshirt for men",
          "productThumbnail": "media/product/black_thirt_p20.jpg",
          "__v": 0
        },

        {
          "_id": "5349b4dji2781d08c09890f3",
          "productName": "Women Tshirt",
          "productDisplayPrice": 220.0,
          "productActualPrice": 155.0,
          "productDesc": "all brands of tshirt for women",
          "productThumbnail": "media/product/black_thirt_p50.jpg",
          "__v": 0
        },

      ];

      // Act
      List<Product> ppp =
          product.map((prod) => Product.fromJson(prod)).toList();

      // Assert
      expect(ppp.length, 2);
      expect(ppp[0].productName, 'Man Tshirt');
      expect(ppp[1].productName, 'Women Tshirt');
    });
    


    test('test 2', () async {
      List<Map<String, dynamic>> product = [];

      // Act
      List<Product> pp =
          product.map((prod) => Product.fromJson(prod)).toList();

      // Assert
      expect(pp.length, 0);
    });


    
  
  });
}
