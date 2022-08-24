import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';
@JsonSerializable(explicitToJson: true)
class ResponseUser {
  bool? success;
  String? token;

  ResponseUser({this.success, this.token});

  // factory ResponseUser.fromJson(Map<String, dynamic> json) {
  //   return ResponseUser(
  //     success: json['success'],
  //     token: json['token'],
  //   );
  // }

  factory ResponseUser.fromJson(Map<String, dynamic> json) =>
      _$ResponseUserFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseUserToJson(this);


}



class ResponseUserProfile<T> {
  bool? success;
  T? data;

  ResponseUserProfile({
    this.success=false, 
    this.data
    });

}