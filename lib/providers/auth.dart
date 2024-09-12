import 'package:flutter_todo/service/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth.g.dart';

@riverpod
Auth auth(AuthRef ref) {
  return Auth();
}

class Auth {
  final AuthService _authService;

  Auth() : _authService = AuthService();

  Future<AuthResponse> signUp(String email, String password) async {
    return await _authService.signUp(email, password);
  }

  Future<AuthResponse> signInWithPassword(String email, String password) async {
    return await _authService.signInWithPassword(email, password);
  }

  Future<void> signOut() async {
    return await _authService.signOut();
  }

  Future<void> resetPasswordForEmail(String email) async {
    return await _authService.resetPasswordForEmail(email);
  }

  Future<UserResponse> changePassword(String newPassword) async {
    return await _authService.changePassword(newPassword);
  }

  Future<UserResponse> getCurrentUser() async {
    return await _authService.getCurrentUser();
  }
}
