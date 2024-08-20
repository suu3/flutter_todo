import 'package:flutter_todo/screens/card_detail_screen.dart';
import 'package:flutter_todo/screens/card_list_screen.dart';
import 'package:flutter_todo/screens/category_selection_screen.dart';
import 'package:flutter_todo/screens/todo_list_screen.dart';

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
      path: routes.todoList,
      builder: (context, state) => const TodoListScreen(),
    ),

    //card Routes
    GoRoute(
      path: routes.cardSelect,
      builder: (context, state) => CategorySelectionScreen(),
    ),
    // GoRoute( //이후 카테고리 별 필터링 정보 조회 라우팅
    //   path: '/category/:id', // :id는 파라미터를 의미
    //   builder: (context, state) {
    //     final String categoryId = state.params['id']!;
    //     return CategoryScreen(id: categoryId);
    //   },
    // ),
    GoRoute(
      path: routes.cardList,
      builder: (context, state) => const CardListScreen(),
    ),
    // GoRoute(
    //   path: '${routes.cardDetail}/:id',
    //   builder: (context, state) {
    //     final todoId = state.pathParameters['id']!;
    //     return const CardDetailScreen(
    //       todoId: '1',
    //     );
    //   },
    // ),
    GoRoute(
      path: '${routes.cardDetail}/:id',
      builder: (context, state) {
        final todoId = state.pathParameters['id']!;
        return CardDetailScreen(
          todoId: todoId,
        );
      },
    ),
  ],
);
