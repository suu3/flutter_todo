import 'package:flutter_todo/constants/routes.dart' as routes;
import 'package:supabase_flutter/supabase_flutter.dart';

bool isPublicRoute(String uri) {
  return routes.publicRoutes.contains(uri);
}

String? redirectBySession(String uri, Session? session) {
  if (session == null) {
    if (!isPublicRoute(uri)) {
      return routes.signIn;
    }
  } else {
    if (isPublicRoute(uri)) {
      return routes.mainEndpoint;
    }
  }

  return null;
}
