import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isTokenExpired() async {
  final prefs = await SharedPreferences.getInstance();

  final int expire = prefs.getInt('expire') ?? 0;

  if (expire == -1) return false;
  if (expire == 0) return true;

  final double now = DateTime.now().millisecondsSinceEpoch / 1000;

  return expire <= now;
}

Future<bool> refreshToken() async {
  // final prefs = await SharedPreferences.getInstance();

  return false;
}

Future<Link> getGraphQLLink() async {
  final prefs = await SharedPreferences.getInstance();

  final HttpLink httpLink = HttpLink(
    (prefs.getString('url') ?? 'https://gitlab.com') + '/api/graphql',
  );

  final AuthLink authLink = AuthLink(
    getToken: () async {
      if (await isTokenExpired()) {
        await refreshToken();
      }
      return 'Bearer ' + (prefs.getString('token') ?? '');
    },
  );

  return authLink.concat(httpLink);
}
