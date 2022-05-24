import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:gitlab_mobile/pages/index.dart';
import 'package:gitlab_mobile/pages/login.dart';
import 'package:gitlab_mobile/pages/my_repositories.dart';
import 'package:gitlab_mobile/pages/starred_repositories.dart';
import 'package:gitlab_mobile/theme.dart';
import 'package:gitlab_mobile/util/auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();

  AppLinks().uriLinkStream.listen((uri) {
    debugPrint(uri.toString());
  });

  String initialRoute = '/';
  if (await isTokenExpired() && !await refreshToken()) {
    initialRoute = '/login';
  }

  final Link link = await getGraphQLLink();

  ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore())));

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
