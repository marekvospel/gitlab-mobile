import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginRoute extends StatelessWidget {
  const LoginRoute({Key? key, required this.graphql}) : super(key: key);
  final ValueNotifier<GraphQLClient> graphql;

  static const String _charset =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';

  static String _createCodeVerifier(int length) {
    return List.generate(
            length, (i) => _charset[Random.secure().nextInt(_charset.length)])
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        IconButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            final codeVerifier = _createCodeVerifier(128);
            final state = _createCodeVerifier(32);

            const String url = 'https://gitlab.com';
            const String clientId =
                '6058016ae83159fd993543039d7a595b59a851918b97f81a1ceba717dd888919';

            await prefs.setString(
              'codeVerifier:$state',
              jsonEncode({
                'client_id': clientId,
                'verifier': codeVerifier,
                'url': url,
              }),
            );

            final grant = oauth2.AuthorizationCodeGrant(
              clientId,
              Uri.parse('$url/oauth/authorize/'),
              Uri.parse('$url/oauth/token/'),
              codeVerifier: codeVerifier,
            );

            final authorizationUrl = grant.getAuthorizationUrl(
              Uri.parse('gitlabmobile://oauth'),
              scopes: [
                'api',
                'read_api',
                'read_user',
                'read_repository',
              ],
              state: state,
            );

            debugPrint(authorizationUrl.toString());

            await launchUrl(
              authorizationUrl,
              mode: LaunchMode.externalApplication,
            );
          },
          icon: const Icon(Icons.lock_outlined),
        )
      ],
    ));
  }
}
