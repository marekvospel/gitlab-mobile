import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Link> getGraphQLLink() async {
  final prefs = await SharedPreferences.getInstance();

  final HttpLink httpLink = HttpLink('https://gitlab.com/api/graphql');

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer ' + (prefs.getString('token') ?? ''),
  );

  return authLink.concat(httpLink);
}
