import 'package:flutter/material.dart';
import 'package:flutter_todo/service/auth.dart';
import 'package:flutter_todo/utils/toast.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_todo/constants/routes.dart' as routes;

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreennState();
}

class _ChangePasswordScreennState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _changePassword() async {
    final AuthService authService = AuthService();
    final newPassword = _passwordController.text;

    try {
      await authService.changePassword(
        newPassword,
      );

      if (mounted) {
        context.push(routes.mainEndpoint);
        showSuccessToast(context: context, text: "비밀번호가 성공적으로 변경되었습니다.");
      }
    } catch (error) {
      if (mounted) {
        showErrorToast(context: context, text: "알수없는 오류가 발생했습니다.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('비밀번호 재설정')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: '새 비밀번호'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changePassword,
              child: const Text('비밀번호 변경하기'),
            ),
          ],
        ),
      ),
    );
  }
}
