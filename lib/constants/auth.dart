import './routes.dart' as routes;
import 'package:supabase_flutter/supabase_flutter.dart';

const List<String> authRoutes = [
  routes.signIn,
  routes.signUp,
  routes.findPassword,
];

const String mainEndpoint = routes.home;

bool isAuthRoute(String uri) {
  return authRoutes.contains(uri);
}

String? redirectBySession(String uri, Session? session) {
  if (session == null) {
    if (!isAuthRoute(uri)) {
      return routes.signIn;
    }
  } else {
    if (isAuthRoute(uri)) {
      return routes.home;
    }
  }
  return null;
}
