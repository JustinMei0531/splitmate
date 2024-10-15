import "package:json_annotation/json_annotation.dart";

part "user_model.g.dart";

@JsonSerializable()
class User {
  final String name; // Username
  final String email; // User email
  final String password;
  final String password_confirmation;

  User(
      {required this.name,
      required this.email,
      required this.password,
      required this.password_confirmation});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
