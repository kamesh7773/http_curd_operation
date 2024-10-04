
import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  String? id;
  String? avatar;
  String? name;
  String? email;

  Users({
    this.id,
    this.avatar,
    this.name,
    this.email,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        avatar: json["avatar"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "name": name,
        "email": email,
      };
}