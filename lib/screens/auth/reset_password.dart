import 'package:flutter/material.dart';
import 'package:flutter_todo/service/auth.dart';
import 'package:flutter_todo/utils/loading_dialog.dart';
import 'package:flutter_todo/utils/toast.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _resetPassword() async {
    final AuthService authService = AuthService();
    final email = _emailController.text;

    showLoadingDialog(context);

    try {
      await authService.resetPasswordForEmail(
        email,
      );

      if (mounted) {
        showSuccessToast(context: context, text: "비밀번호 재설정 메일을 보냈습니다.");
      }
    } catch (error) {
      if (mounted) {
        showErrorToast(context: context, text: "알수없는 오류가 발생했습니다.");
      }
    } finally {
      if (mounted) {
        hideLoadingDialog(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('비밀번호 재설정'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetPassword,
              child: const Text('비밀번호 재설정 링크 보내기'),
            ),
          ],
        ),
      ),
    );
  }
}
