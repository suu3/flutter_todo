import 'package:flutter_todo/screens/category_selection_screen.dart';
import 'package:flutter_todo/screens/todo_detail_screen.dart';
import 'package:flutter_todo/screens/todo_list_screen.dart';

import 'package:go_router/go_router.dart';
import 'screens/auth/sign_in.dart';
import 'screens/auth/sign_up.dart';
import 'screens/auth/reset_password.dart';
import 'screens/auth/change_password.dart';
import 'screens/todo_create_screen.dart';
import 'constants/routes.dart' as routes;

final GoRouter router = GoRouter(
  initialLocation: routes.signIn,
  //initialLocation: routes.todoCreate,
  // redirect: (context, state) {
  //   final session = Supabase.instance.client.auth.currentSession;
  //   return auth.redirectBySession(state.uri.toString(), session);
  // },
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
      path: '/todo/detail/:id',
      builder: (context, state) {
        final todoId = state.pathParameters['id']?.toLowerCase();
        return TodoDetailScreen(todoId: todoId!);
      },
    ),

    GoRoute(
      path: '/todo/:categoryId',
      builder: (context, state) {
        final categoryId = state.pathParameters['categoryId']?.toLowerCase();
        return TodoListScreen(categoryId: categoryId);
      },
    ),

    //category Routes
    GoRoute(
      path: routes.categorySelect,
      builder: (context, state) => CategorySelectionScreen(),
    ),
  ],
);
