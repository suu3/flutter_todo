import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/providers/auth.dart';
import 'package:flutter_todo/utils/toast.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_todo/constants/routes.dart' as routes;
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreennState();
}

class _ChangePasswordScreennState extends ConsumerState<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _changePassword() async {
    final auth = ref.read(authProvider);
    final newPassword = _passwordController.text;

    try {
      await auth.changePassword(
        newPassword,
      );

      if (mounted) {
        context.push(routes.mainEndpoint);
        showSuccessToast(context: context, text: "비밀번호가 성공적으로 변경되었습니다.");
      }
    } catch (error) {
      if (mounted) {
        if (error is AuthException && error.hashCode == 97716469) {
          showErrorToast(
              context: context, text: "새 비밀번호는 이전 비밀번호와 같은 비밀번호로 설정할 수 없습니다.");
        } else if (error.hashCode == 406998593) {
          showErrorToast(context: context, text: "비밀번호는 6자 이상으로 설정해주세요.");
        } else {
          showErrorToast(context: context, text: "알수없는 오류가 발생했습니다.");
        }
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
