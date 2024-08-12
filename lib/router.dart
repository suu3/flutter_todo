import 'package:flutter_todo/screens/temp/card_detail_screen.dart';
import 'package:flutter_todo/screens/card_list_screen.dart';
import 'package:flutter_todo/screens/temp/category_selection_screen.dart';
import 'package:flutter_todo/screens/temp/todo_list_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/auth/sign_in.dart';
import 'screens/auth/sign_up.dart';
import 'screens/auth/reset_password.dart';
import 'screens/auth/change_password.dart';
import 'screens/todo_create_screen.dart';
import 'constants/routes.dart' as routes;
import 'utils/auth.dart' as auth;

final GoRouter router = GoRouter(
  initialLocation: routes.signIn,
  redirect: (context, state) {
    final session = Supabase.instance.client.auth.currentSession;
    return auth.redirectBySession(state.uri.toString(), session);
  },
  routes: [
    //auth Routes
    GoRoute(
      path: routes.signIn,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: routes.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: routes.resetPassword,
      builder: (context, state) => const ResetPasswordScreen(),
    ),
    GoRoute(
      path: routes.changePassword,
      builder: (context, state) => const ChangePasswordScreen(),
    ),

    // todo Routes
    GoRoute(
      path: routes.todoCreate,
      builder: (context, state) => const TodoCreateScreen(),
    ),
    GoRoute(
      path: routes.todoList,
      builder: (context, state) => const TodoListScreen(),
    ),

    //card Routes
    GoRoute(
      path: routes.cardSelect,
      builder: (context, state) => const CategorySelectionScreen(),
    ),
    GoRoute(
      path: routes.cardList,
      builder: (context, state) => const CardListScreen(),
    ),
    GoRoute(
      path: '${routes.cardDetail}/:id',
      builder: (context, state) {
        final todoId = state.pathParameters['id']!;
        return CardDetailScreen(todoId: todoId);
      },
    ),
  ],
);
