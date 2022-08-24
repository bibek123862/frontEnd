// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addToCartModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToCart _$AddToCartFromJson(Map<String, dynamic> json) => AddToCart(
      id: json['_id'] as String?,
      productQuantity: json['productQuantity'] as String?,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      cartAddedBy: json['cartAddedBy'] as String?,
    );

Map<String, dynamic> _$AddToCartToJson(AddToCart instance) => <String, dynamic>{
      '_id': instance.id,
      'productQuantity': instance.productQuantity,
      'product': instance.product,
      'cartAddedBy': instance.cartAddedBy,
    };
