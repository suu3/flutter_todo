import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/screens/auth/change_password.dart';
import 'package:flutter_todo/screens/auth/reset_password.dart';
import 'package:flutter_todo/screens/todo_create_screen.dart';
import 'package:flutter_todo/theme.dart';
import 'package:flutter_todo/screens/auth/sign_in.dart';
import 'package:flutter_todo/screens/auth/sign_up.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'constants/routes.dart' as routes;
import 'utils/auth.dart' as auth;
import 'util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
  );

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: routes.signIn,
    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      return auth.redirectBySession(state.uri.toString(), session);
    },
    routes: [
      GoRoute(
        path: routes.home,
        builder: (context, state) => const TodoCreateScreen(),
      ),
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
        builder: (context, state) => const ResetPasswordPage(),
      ),
      GoRoute(
        path: routes.changePassword,
        builder: (context, state) => const ChangePasswordPage(),
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(
      context,
    );

    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      routerDelegate: _router.routerDelegate,
      title: 'Flutter Demo',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
    );
  }
}
