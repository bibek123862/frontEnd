// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseProduct _$ResponseProductFromJson(Map<String, dynamic> json) =>
    ResponseProduct(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseProductToJson(ResponseProduct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
