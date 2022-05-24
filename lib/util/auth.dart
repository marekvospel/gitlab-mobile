import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TokenResponse {
  final String accessToken;
  final String tokenType;
  final int? expiresIn;
  final String refreshToken;
  final String scope;
  final int createdAt;

  const TokenResponse({
    required this.accessToken,
    required this.tokenType,
    this.expiresIn,
    required this.refreshToken,
    required this.scope,
    required this.createdAt,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
        accessToken: json['access_token'],
        tokenType: json['token_type'],
        expiresIn: json['expires_in'],
        refreshToken: json['refresh_token'],
        scope: json['scope'],
        createdAt: json['created_at']);
  }
}

Future<bool> isTokenExpired() async {
  final prefs = await SharedPreferences.getInstance();

  final int expire = prefs.getInt('expire') ?? 0;

  if (expire == -1) return false;
  if (expire == 0) return true;

  final double now = DateTime.now().millisecondsSinceEpoch / 1000;

  return expire <= now;
}

Future<void> refreshToken() async {
  final prefs = await SharedPreferences.getInstance();

  final Uri uri = Uri.parse(
    (prefs.getString('url') ?? 'https://gitlab.com') + '/oauth/token',
  );
  final String refresh = prefs.getString('refresh_token') ?? '';
  final String clientId = prefs.getString('client_id') ?? '';

  final http.Response response = await http.post(
    uri,
    body: {
      'client_id': clientId,
      'refresh_token': refresh,
      'grant_type': 'refresh_token',
    },
    headers: {'Accept': 'application/json'},
  );

  debugPrint(response.body);
  if (response.statusCode == 200) {
    final TokenResponse data =
        TokenResponse.fromJson(jsonDecode(response.body));

    await prefs.setString('token', data.accessToken);
    await prefs.setString('refresh_token', data.refreshToken);
    await prefs.setInt(
        'expire',
        data.expiresIn == null
            ? -1
            : data.createdAt + ((data.expiresIn as int) * 60));
  } else {
    // TODO: redirect to /login
  }
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
