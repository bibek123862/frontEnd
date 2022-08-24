import 'package:json_annotation/json_annotation.dart';

part 'userModel.g.dart';

@JsonSerializable()
class User {
  final String? username;
  final String? password;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? address;
  final String? profilePicture;


  User({
    this.username, 
    this.password, 
    this.email, 
    this.firstName,
    this.lastName,
    this.address,
    this.profilePicture,
    });



    // factory User.fromJson(Map<String, dynamic> json) => User(
    //     username: json['username'],
    //     password: json['password'],
    //     email: json['email'],
    //     firstName: json['firstName'],
    //     lastName: json['lastName'],
    //     address: json['address'],
    //   );


  factory User.fromJson(Map<String, dynamic> obj) => _$UserFromJson(obj);
  Map<String, dynamic> toJson() => _$UserToJson(this);

}
