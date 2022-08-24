// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['_id'] as String?,
      productName: json['productName'] as String?,
      productDesc: json['productDesc'] as String?,
      productDisplayPrice: (json['productDisplayPrice'] as num?)?.toDouble(),
      productActualPrice: (json['productActualPrice'] as num?)?.toDouble(),
      productThumbnail: json['productThumbnail'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'productName': instance.productName,
      'productDesc': instance.productDesc,
      'productDisplayPrice': instance.productDisplayPrice,
      'productActualPrice': instance.productActualPrice,
      'productThumbnail': instance.productThumbnail,
    };
