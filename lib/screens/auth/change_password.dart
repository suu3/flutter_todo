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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: '새 비밀번호'),
              obscureText: true,
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
                onPressed: _changePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 201, 85),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  '비밀번호 변경하기',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
