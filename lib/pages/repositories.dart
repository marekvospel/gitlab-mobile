import 'package:flutter/material.dart';
import '../scaffolds/child_route.dart';

class RepositoriesRoute extends StatelessWidget {
  const RepositoriesRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return const ChildRouteScaffold(
      username: 'MarekVospel',
      body: Text("List of all repositories"),
    );
  }
}
