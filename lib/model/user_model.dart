import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id = "";
  late String userName;
  late String eMail;
  late String password;

  UserModel({
    this.id = "",
    required this.userName,
    required this.eMail,
    required this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    UserModel(
      id: json["id"],
      userName: json["userName"],
      eMail: json["eMail"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> user = <String, dynamic>{};
    if (id.isNotEmpty) {
      user["id"] = id;
    }
    user["userName"] = userName;
    user["eMail"] = eMail;
    user["password"] = password;
    user["registerTime"] = Timestamp.now();

    return user;
  }
}
