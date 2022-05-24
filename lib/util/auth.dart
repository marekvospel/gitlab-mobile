import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isToken() async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.getString('credentials') == null;
}

Future<bool> isTokenExpired() async {
  final prefs = await SharedPreferences.getInstance();

  final int expire =
      jsonDecode(prefs.getString('credentials') ?? '{}')?['expiration'] ?? 0;

  if (expire == -1) return false;
  if (expire == 0) return true;

  final int now = DateTime.now().millisecondsSinceEpoch;

  return expire <= now;
}

Future<bool> refreshToken() async {
  final prefs = await SharedPreferences.getInstance();
  final creds = jsonDecode(prefs.getString('credentials') ?? '{}');
  oauth2.Credentials(
    creds?['access_token'] ?? '',
    refreshToken: creds?['refresh_token'] ?? '',
    tokenEndpoint: Uri.parse('${creds['url']}/oauth/token'),
  );

  return false;
}

Future<Link> getGraphQLLink() async {
  final prefs = await SharedPreferences.getInstance();

  final String? url =
      jsonDecode(prefs.getString('credentials') ?? '{}')?['url'];

  final HttpLink httpLink = HttpLink(
    '$url/api/graphql',
  );

  final AuthLink authLink = AuthLink(
    getToken: () async {
      if (await isTokenExpired()) {
        await refreshToken();
      }

      final String? token =
          jsonDecode(prefs.getString('credentials') ?? '{}')?['access_token'];
      return 'Bearer $token';
    },
  );

  return authLink.concat(httpLink);
}
