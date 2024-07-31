import 'package:flutter/material.dart';
import 'package:flutter_todo/constants/routes.dart' as routes;
import 'package:flutter_todo/service/auth.dart';
import 'package:flutter_todo/utils/validators.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  final AuthService _authService = AuthService();

  Future<void> _trySignUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await _authService.signUp(_email, _password);

      if (mounted) {
        context.go(routes.signIn);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: '이메일'),
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: '비밀번호'),
                obscureText: true,
                validator: Validators.validatePassword,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: '비밀번호 확인'),
                obscureText: true,
                validator: (value) =>
                    Validators.validateConfirmPassword(value, _password),
                onChanged: (value) {
                  setState(() {});
                },
                onSaved: (value) {},
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _trySignUp,
                child: const Text('회원가입'),
              ),
              TextButton(
                onPressed: () {
                  context.go(routes.signIn);
                },
                child: const Text('로그인'),
              ),
              TextButton(
                onPressed: () {
                  context.go(routes.resetPassword);
                },
                child: const Text('비밀번호 찾기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
