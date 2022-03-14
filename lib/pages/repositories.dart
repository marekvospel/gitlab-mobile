import 'package:flutter/material.dart';
import 'package:gitlab_mobile/scaffolds/child_route.dart';
import 'package:gitlab_mobile/widgets/repositories/list_repository.dart';

class RepositoriesRoute extends StatelessWidget {
  const RepositoriesRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int repositoriesAmount = 2;
    String username = 'MarekVospel';

    return ChildRouteScaffold(
      username: username,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: ListView.separated(
          itemCount: repositoriesAmount,
          itemBuilder: (BuildContext context, int index) => ListRepository(
            username: username,
          ),
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 0,
            thickness: 1,
          ),
        ),
      ),
    );
  }
}
