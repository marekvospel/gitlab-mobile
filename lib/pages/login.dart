import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';

class LoginRoute extends StatelessWidget {
  const LoginRoute({Key? key, required this.graphql}) : super(key: key);
  final ValueNotifier<GraphQLClient> graphql;

  static const String _charset =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';

  static String _createCodeVerifier() {
    return List.generate(
        128, (i) => _charset[Random.secure().nextInt(_charset.length)]).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        IconButton(
          onPressed: () async {
            final codeVerifier = _createCodeVerifier();

            final grant = oauth2.AuthorizationCodeGrant(
              '6058016ae83159fd993543039d7a595b59a851918b97f81a1ceba717dd888919',
              Uri.parse('https://gitlab.com/oauth/authorize/'),
              Uri.parse('https://gitlab.com/oauth/token/'),
              codeVerifier: codeVerifier,
            );

            final authorizationUrl = grant.getAuthorizationUrl(
                Uri.parse('gitlabmobile://oauth'),
                scopes: [
                  'api',
                  'read_api',
                  'read_user',
                  'read_repository',
                ]);

            await launchUrl(
              authorizationUrl,
              mode: LaunchMode.externalApplication,
            );

            // final prefs = await SharedPreferences.getInstance();

            // TODO: get token from https://gitlab.com/oauth/token
            // await prefs.setString('token', '');
            // await prefs.setString('url', 'https://gitlab.com');
            // await prefs.setString('refresh_token', '');
            // await prefs.setInt('expire', 0);
            // await prefs.setString('client_id', '');

            /*
            final client = GraphQLClient(
              link: await getGraphQLLink(),
              cache: GraphQLCache(store: HiveStore()),
            );

            graphql.value = client;

            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushNamed(context, '/');
            }
             */
          },
          icon: const Icon(Icons.lock_outlined),
        )
      ],
    ));
  }
}
