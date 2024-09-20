import 'package:flutter/material.dart';
import 'package:flutter_todo/constants/routes.dart' as routes;
import 'package:flutter_todo/providers/auth.dart';
import 'package:flutter_todo/utils/loading_dialog.dart';
import 'package:flutter_todo/utils/toast.dart';
import 'package:flutter_todo/utils/validators.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _signUp() async {
    final auth = ref.read(authProvider);

    if (_formKey.currentState!.validate()) {
      showLoadingDialog(context);

      try {
        await auth.signUp(_emailController.text, _passwordController.text);

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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _emailController,
                autofocus: true,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
                decoration: const InputDecoration(labelText: '이메일'),
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
              ),
              TextFormField(
                controller: _passwordController,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
                decoration: const InputDecoration(labelText: '비밀번호'),
                obscureText: true,
                validator: Validators.validatePassword,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                textInputAction: TextInputAction.done, // 마지막 필드에서는 done 사용
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).unfocus(), // 포커스를 해제하거나 제출 완료 처리
                decoration: const InputDecoration(labelText: '비밀번호 확인'),
                obscureText: true,
                validator: (value) => Validators.validateConfirmPassword(
                    value, _passwordController.text),
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
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 201, 85),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    '회원가입',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    context.push(routes.resetPassword);
                  },
                  child: const Text(
                    '비밀번호 찾기',
                    style: TextStyle(color: Colors.black38),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
