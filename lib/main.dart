import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:gitlab_mobile/pages/index.dart';
import 'package:gitlab_mobile/pages/login.dart';
import 'package:gitlab_mobile/pages/my_repositories.dart';
import 'package:gitlab_mobile/pages/starred_repositories.dart';
import 'package:gitlab_mobile/theme.dart';
import 'package:gitlab_mobile/util/auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await initHiveForFlutter();
  final prefs = await SharedPreferences.getInstance();

  String initialRoute = '/';
  if (await isToken() && await isTokenExpired() && !await refreshToken()) {
    initialRoute = '/login';
  }

  final Link link = await getGraphQLLink();

  ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore())));

  AppLinks().uriLinkStream.listen((uri) async {
    if (uri.toString().startsWith('gitlabmobile://oauth')) {
      final String? verifier =
          prefs.getString('codeVerifier:${uri.queryParameters['state'] ?? ''}');
      prefs.remove('codeVerifier:${uri.queryParameters['state'] ?? ''}');

      if (verifier == null) return;

      final json = jsonDecode(verifier);

      final grant = oauth2.AuthorizationCodeGrant(
        json['client_id'],
        Uri.parse('${json['url']}/oauth/authorize'),
        Uri.parse('${json['url']}/oauth/token'),
        codeVerifier: json['verifier'],
      );
      grant.getAuthorizationUrl(Uri.parse('gitlabmobile://oauth'));

      try {
        final authClient =
            await grant.handleAuthorizationResponse(uri.queryParameters);

        await prefs.setString(
            'credentials',
            jsonEncode({
              'access_token': authClient.credentials.accessToken,
              'refresh_token': authClient.credentials.refreshToken,
              'url': json['url'],
              'expiration':
                  authClient.credentials.expiration?.millisecondsSinceEpoch ??
                      -1
            }));

        client.value = GraphQLClient(
            link: await getGraphQLLink(),
            cache: GraphQLCache(store: HiveStore()));
        debugPrint(prefs.getString('credentials'));
      } catch (e) {
        throw Exception(e);
      }
    }
  });

  runApp(GraphQLProvider(
      client: client,
      child: MyApp(
        graphql: client,
        initialRoute: initialRoute,
      )));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> graphql;
  final String initialRoute;

  const MyApp({
    Key? key,
    required this.graphql,
    this.initialRoute = '/',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Gitlab Mobile',
        theme: theme,
        darkTheme: darkTheme,
        initialRoute: initialRoute,
        routes: {
          '/': (context) => const IndexRoute(),
          '/repositories/starred': (context) =>
              const StarredRepositoriesRoute(),
          '/repositories/my': (context) => const MyRepositoriesRoute(),
          '/login': (context) => LoginRoute(
                graphql: graphql,
              ),
        });
  }
}
