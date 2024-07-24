import 'package:flutter/material.dart';
import 'package:flutter_todo/constants/routes.dart';
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

      try {
        await _authService.signUp(_email, _password);
        Fluttertoast.showToast(
          msg: "회원가입 성공!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        // 회원가입 후 다른 화면으로 이동
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

        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } catch (error) {
        Fluttertoast.showToast(
          msg: "회원가입 중 알 수 없는 오류가 발생했습니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
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
                  context.go(Routes.signIn);
                },
                child: const Text('로그인'),
              ),
              TextButton(
                onPressed: () {
                  context.go(Routes.findPassword);
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
