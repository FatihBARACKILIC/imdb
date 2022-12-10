import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imdb/model/user_model.dart';

class FirebaseServices {
  static final CollectionReference userRef =
      FirebaseFirestore.instance.collection("users");

  static Future<String> registerUser({
    required String userName,
    required String eMail,
    required String password,
  }) async {
    var document = userRef.doc();
    String id = document.id;

    final oldMails = await userRef.where("eMail", isEqualTo: eMail).get().then(
          (value) => value.docs,
        );

    if (oldMails.isNotEmpty) {
      return "registered";
    }

    final user = UserModel(
      userName: userName,
      eMail: eMail,
      password: password,
    );

    try {
      await document.set(user.toJson());

      return id;
    } catch (e) {
      return "";
    }
  }

  static Future getUserId({
    required String eMail,
    required String password,
  }) async {
    try {
      final result = await userRef
          .where("eMail", isEqualTo: eMail)
          .where("password", isEqualTo: password)
          .get()
          .then(
            (value) => value.docs[0],
          );

      return result.id;
    } catch (e) {
      return "";
    }
  }

  static Future getUserInfo(String id) async {
    try {
      Map result = await userRef
          .doc(id)
          .get()
          .then((value) => value.data() as Map<String, dynamic>);

      if (result.isNotEmpty) {
        return [
          result["userName"],
          result["eMail"],
          result["password"],
        ];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<String> updateUser({
    required String id,
    required String userName,
    required String eMail,
    required String password,
  }) async {
    var document = userRef.doc(id);

    final oldMails = await userRef.where("eMail", isEqualTo: eMail).get().then(
          (value) => value.docs,
        );

    if (oldMails.isNotEmpty && oldMails[0].id != id) {
      return "registered";
    }

    final user = UserModel(
      userName: userName,
      eMail: eMail,
      password: password,
    );

    try {
      await document.set(user.toJson());

      return id;
    } catch (e) {
      return "";
    }
  }
}
