import 'package:clothing_roll/model/addToCartModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'addToCart_response.g.dart';



@JsonSerializable(explicitToJson: true)
class CartListResponse {
  bool success;
  final List<AddToCart> data;

  CartListResponse({    
    required this.success, 
    required this.data
  });

  factory CartListResponse.fromJson(Map<String, dynamic> json) => 
    _$CartListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartListResponseToJson(this);
}




class AddToCartResponse {
  bool? success;


  AddToCartResponse({this.success});

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) {
    return AddToCartResponse(
      success: json['success'],
    );
  }
}


