import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<String?> sign_up({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final UserCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await UserCredential.user!.updateDisplayName(username);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'Email đã được đăng ký vui lòng chọn Email khác';
      } else if (e.code == 'weak-password') {
        return 'Mật khẩu quá yếu ( số ký tự >=6)';
      } else {
        return e.message ?? 'Lỗi không xác định chờ xíu nhé';
      }
    }
  }

  static Future<String?> log_in({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Tài khoản không tồn tại';
      } else if (e.code == 'wrong-password') {
        return 'Sai mật khẩu';
      } else {
        return e.message ?? ' Lỗi không xác định chờ xíu nhé';
      }
    }
  }
}
