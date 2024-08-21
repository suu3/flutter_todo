import 'package:flutter/material.dart';
import 'package:flutter_todo/constants/routes.dart' as routes;
import 'package:flutter_todo/service/auth.dart';
import 'package:flutter_todo/utils/toast.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;
  String _email = '';
  String _password = '';

  Future<void> _signIn() async {
    final AuthService authService = AuthService();
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    try {
      final AuthResponse res = await authService.signInWithPassword(
        _email,
        _password,
      );

      final Session? session = res.session;

      if (session != null && mounted) {
        showSuccessToast(
          context: context,
          text: "환영합니다!",
        );
        context.push(routes.mainEndpoint);
      }
    } catch (error) {
      if (mounted) {
        if (error is AuthException &&
            error.statusCode == '400' &&
            error.message.contains("Email not confirmed")) {
          showToast(
            context: context,
            text: "이메일 인증을 완료해주세요.",
          );
        } else {
          showErrorToast(
            context: context,
            text: "로그인 중 알 수 없는 오류가 발생했습니다.",
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '로그인',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: '이메일',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '이메일을 입력하세요';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _email = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: '비밀번호',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '비밀번호를 입력하세요';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _password = value!;
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _signIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 175, 118),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              '로그인',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        TextButton(
                          onPressed: () {
                            context.push(routes.signUp);
                          },
                          child: const Text(
                            '회원가입',
                            style: TextStyle(color: Colors.black38),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            context.push(routes.resetPassword);
                          },
                          child: const Text(
                            '비밀번호 찾기',
                            style: TextStyle(color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
