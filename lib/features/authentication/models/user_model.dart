import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class UserModel {
  final String uid;
  final String? email;
  final String? name;

  UserModel({required this.uid, this.email, this.name});

  factory UserModel.fromFirebaseUser(firebase_auth.User user) {
    return UserModel(uid: user.uid, email: user.email, name: user.displayName);
  }
}
