// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseUser _$ResponseUserFromJson(Map<String, dynamic> json) => ResponseUser(
      success: json['success'] as bool?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ResponseUserToJson(ResponseUser instance) =>
    <String, dynamic>{
      'success': instance.success,
      'token': instance.token,
    };
