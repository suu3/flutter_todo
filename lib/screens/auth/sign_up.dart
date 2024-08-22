import 'package:flutter/material.dart';
import 'package:flutter_todo/constants/routes.dart' as routes;
import 'package:flutter_todo/service/auth.dart';
import 'package:flutter_todo/utils/loading_dialog.dart';
import 'package:flutter_todo/utils/toast.dart';
import 'package:flutter_todo/utils/validators.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  Future<void> _signUp() async {
    final AuthService authService = AuthService();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      showLoadingDialog(context);

      try {
        await authService.signUp(_email, _password);

        if (mounted) {
          showSuccessToast(
            context: context,
            text: "메일이 발송되었습니다. 메일함을 확인해주세요.",
          );
          context.push(routes.signIn);
        }
      } catch (error) {
        if (mounted) {
          if (error is AuthException && error.statusCode == '409') {
            showErrorToast(
              context: context,
              text: "이미 가입된 이메일입니다.",
            );
          } else {
            showErrorToast(
              context: context,
              text: "회원가입 중 알 수 없는 오류가 발생했습니다.",
            );
          }
        }
      } finally {
        if (mounted) {
          hideLoadingDialog(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 텍스트를 왼쪽 정렬
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
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  '* 비밀번호는 6자 이상으로 설정해주세요.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _signUp,
                  child: const Text('회원가입하기'),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    context.push(routes.resetPassword);
                  },
                  child: const Text('비밀번호 찾기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
