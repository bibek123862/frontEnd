// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      username: json['username'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      address: json['address'] as String?,
      profilePicture: json['profilePicture'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'address': instance.address,
      'profilePicture': instance.profilePicture,
    };
