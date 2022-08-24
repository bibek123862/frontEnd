import 'package:clothing_roll/model/productModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'addToCartModel.g.dart';


@JsonSerializable()
class AddToCart {
  @JsonKey(name:'_id')
  final String? id;
  final String? productQuantity;
  final Product? product;
  final String? cartAddedBy;


  AddToCart({
    this.id,
    this.productQuantity, 
    this.product, 
    this.cartAddedBy, 
    });


  factory AddToCart.fromJson(Map<String, dynamic> json) => _$AddToCartFromJson(json);
  Map<String, dynamic> toJson() => _$AddToCartToJson(this);
}
