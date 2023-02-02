import 'package:authenticate_bloc/exceptions/authenticate_exception.dart';

import '../models/user_model.dart';

class AuthenticationService {
  Future<User?> getCurrentUser() async {
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email.toLowerCase() != 'long' || password != '1234') {
      throw AuthenticationException(message: "Wrong username or password");
    }
    return User(name: "Test user", email: email);
  }

  Future? signOut() {
    return null;
  }
}
