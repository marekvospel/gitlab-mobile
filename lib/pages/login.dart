import 'package:flutter/material.dart';
import 'package:gitlab_mobile/util/auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRoute extends StatelessWidget {
  const LoginRoute({Key? key, required this.graphql}) : super(key: key);
  final ValueNotifier<GraphQLClient> graphql;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        IconButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();

              // TODO: get token from https://gitlab.com/oauth/token
              await prefs.setString('token', '');

              final client = GraphQLClient(
                  link: await getGraphQLLink(),
                  cache: GraphQLCache(store: HiveStore()));

              graphql.value = client;

              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.pushNamed(context, '/');
              }
            },
            icon: const Icon(Icons.lock_outlined))
      ],
    ));
  }
}
