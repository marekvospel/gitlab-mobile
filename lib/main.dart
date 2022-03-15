import 'package:flutter/material.dart';
import 'package:gitlab_mobile/pages/index.dart';
import 'package:gitlab_mobile/pages/starred_repositories.dart';
import 'package:gitlab_mobile/theme.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();

  final HttpLink httpLink =
      HttpLink('https://gitlab.polygon.school/api/graphql');

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer ',
  );

  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore())));

  runApp(GraphQLProvider(client: client, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        });
  }
}
