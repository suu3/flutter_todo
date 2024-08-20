import 'package:flutter/material.dart';
import 'package:flutter_todo/constants/routes.dart' as routes;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client;

  AuthService() : _client = Supabase.instance.client;

  void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _showErrorToast(String message) {
    _showToast(message, Colors.red);
  }

  void _showSuccessToast(String message) {
    _showToast(message, Colors.green);
  }

  Future<AuthResponse> signUp(String email, String password) async {
    try {
      final AuthResponse res = await _client.auth.signUp(
        email: email,
        password: password,
      );

      _showSuccessToast("회원가입이 완료되었습니다.");
      return res;
    } on AuthException catch (error) {
      String errorMessage = "회원가입 중 오류가 발생했습니다: ${error.message}";
      switch (error.statusCode) {
        case '400':
          errorMessage = "잘못된 요청입니다.";
          break;
        case '409':
          errorMessage = "이미 존재하는 이메일입니다.";
          break;
      }

      _showErrorToast(errorMessage);
      rethrow;
    } catch (error) {
      _showErrorToast("회원가입 중 알 수 없는 오류가 발생했습니다.");
      rethrow;
    }
  }

  Future<AuthResponse> signInWithPassword(String email, String password) async {
    try {
      final AuthResponse res = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final Session? session = res.session;
      print("sign in $res");
      if (session != null) {
        _showSuccessToast("환영합니다!");
      } else {
        _showErrorToast("로그인 중 오류가 발생했습니다.");
      }

      return res;
    } on AuthException catch (error) {
      String errorMessage = "로그인 중 오류가 발생했습니다. ${error.message}";

      if (error.statusCode == '400') {
        errorMessage = "존재하지 않는 계정입니다.";
      }

      _showErrorToast(errorMessage);

      rethrow;
    } catch (error) {
      _showErrorToast("로그인 중 알 수 없는 오류가 발생했습니다.");

      rethrow;
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<void> resetPasswordForEmail(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(
        email,
        redirectTo: routes.changePassword, // 인증된 사용자만 접근 가능해야 함
      );
      _showSuccessToast("비밀번호 재설정 메일을 보냈습니다.");
    } catch (error) {
      print("error $error");
      _showErrorToast("Error: ${error.toString()}");
      rethrow;
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      await _client.auth.updateUser(
        UserAttributes(password: newPassword),
      );
      _showSuccessToast("비밀번호가 성공적으로 변경되었습니다.");
    } catch (error) {
      _showErrorToast("Error: ${error.toString()}");
      rethrow;
    }
  }

  Future<UserResponse> getCurrentUser() async {
    try {
      final UserResponse res = await _client.auth.getUser();
      return res;
    } catch (error) {
      rethrow;
    }
  }
}
