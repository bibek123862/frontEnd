// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addToCart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartListResponse _$CartListResponseFromJson(Map<String, dynamic> json) =>
    CartListResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => AddToCart.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartListResponseToJson(CartListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
