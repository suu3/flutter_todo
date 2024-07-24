import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client;

  AuthService() : _client = Supabase.instance.client;

  Future<AuthResponse> signUp(String email, String password) async {
    final AuthResponse res = await _client.auth.signUp(
      email: email,
      password: password,
    );
    return res;
  }

  Future<AuthResponse> signInWithPassword(String email, String password) async {
    final AuthResponse res = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return res;
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
