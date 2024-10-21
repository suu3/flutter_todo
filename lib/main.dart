import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/router.dart';
import 'package:flutter_todo/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uni_links/uni_links.dart';
import 'utils/create_text_theme.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
  );

  FlutterNativeSplash.remove();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();

    _router = router;

    _handleDeepLink();
  }

  // 앱이 열려 있는 상태에서 딥링크 열었을 때 처리 함수
  void _handleDeepLink() {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        // 딥링크로 전달된 경로를 GoRouter에서 처리
        _router.go('/${uri.host}${uri.path}?${uri.query}');
      }
    }, onError: (err) {
      print('Deep link error: $err');
    });
  }

  @override
  void dispose() {
    _sub?.cancel(); // 딥링크 스트림 구독 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context);
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      routerDelegate: _router.routerDelegate,
      title: 'Flutter TO DO',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
    );
  }
}
