import 'package:clothing_roll/model/productModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ResponseProduct {
  bool success;
  final List<Product> data;

  ResponseProduct({
    required this.success, 
    required this.data
    });

  factory ResponseProduct.fromJson(Map<String, dynamic> json) => 
    _$ResponseProductFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseProductToJson(this);
}




// @JsonSerializable(explicitToJson: true)
class ResponseProductDetail<T> {
  bool? success;
  T? data;

  ResponseProductDetail({
    this.success=false, 
    this.data
    });

  // factory ResponseProductDetail.fromJson(Map<String, dynamic>json){
  //    return ResponseProductDetail(
  //     success: json['success'],
  //     data: json['data'],
  //   );
  // }
}




