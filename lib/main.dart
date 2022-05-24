import 'package:flutter/material.dart';
import 'package:gitlab_mobile/pages/index.dart';
import 'package:gitlab_mobile/pages/login.dart';
import 'package:gitlab_mobile/pages/starred_repositories.dart';
import 'package:gitlab_mobile/theme.dart';
import 'package:gitlab_mobile/util/auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();

  final Link link = await getGraphQLLink();

  ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore())));

  runApp(GraphQLProvider(
      client: client,
      child: MyApp(
        graphql: client,
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.graphql}) : super(key: key);
  final ValueNotifier<GraphQLClient> graphql;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Gitlab Mobile',
        theme: theme,
        darkTheme: darkTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const IndexRoute(),
          '/starred_repositories': (context) =>
              const StarredRepositoriesRoute(),
          '/login': (context) => LoginRoute(
                graphql: graphql,
              ),
        });
  }
}
