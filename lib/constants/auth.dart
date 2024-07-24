import 'package:flutter_todo/constants/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const List<String> authRoutes = [
  Routes.signIn,
  Routes.signUp,
  Routes.findPassword,
];

const String mainEndpoint = Routes.home;

bool isAuthRoute(String uri) {
  return authRoutes.contains(uri);
}

String? redirectBySession(String uri, Session? session) {
  if (session == null) {
    // Not logged in, redirect to login page if trying to access a protected route
    if (!isAuthRoute(uri)) {
      return Routes.signIn;
    }
  } else {
    // Logged in, redirect to home if trying to access auth pages
    if (isAuthRoute(uri)) {
      return Routes.home;
    }
  }
  return null;
}
