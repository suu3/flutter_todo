import './routes.dart' as routes;
import 'package:supabase_flutter/supabase_flutter.dart';

const List<String> publicRoutes = [
  routes.signIn,
  routes.signUp,
  routes.resetPassword,
];

const String mainEndpoint = routes.home;

bool isPublicRoute(String uri) {
  return publicRoutes.contains(uri);
}

String? redirectBySession(String uri, Session? session) {
  if (session == null) {
    if (!isPublicRoute(uri)) {
      return routes.signIn;
    }
  } else {
    if (isPublicRoute(uri)) {
      return routes.home;
    }
  }
  return null;
}
