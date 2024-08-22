import 'package:flutter_todo/constants/routes.dart' as routes;
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client;

  AuthService() : _client = Supabase.instance.client;

  Future<AuthResponse> signUp(String email, String password) async {
    final AuthResponse res = await _client.auth.signUp(
      email: email,
      password: password,
    );

    if (res.user!.identities!.isEmpty) {
      throw const AuthException('이미 가입된 이메일입니다.', statusCode: '409');
    }

    return res;
  }

  Future<AuthResponse> signInWithPassword(String email, String password) async {
    final AuthResponse res = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (res.session == null) {
      throw Exception('세션이 존재하지 않습니다.');
    }

    return res;
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<void> resetPasswordForEmail(String email) async {
    await _client.auth.resetPasswordForEmail(
      email,
      redirectTo: routes.changePassword, // 인증된 사용자만 접근 가능해야 함
    );
  }

  Future<void> changePassword(String newPassword) async {
    await _client.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }
}
