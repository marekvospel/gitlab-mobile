import 'package:flutter/material.dart';
import 'package:gitlab_mobile/scaffolds/child_route.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../widgets/repositories/list_repository.dart';

class StarredRepositoriesRoute extends StatelessWidget {
  const StarredRepositoriesRoute({Key? key}) : super(key: key);

  RepositoryStatus pipelineToStatus(List? nodes) {
    if (nodes == null || nodes.isEmpty) return RepositoryStatus.none;

    String? status = nodes[0]?['status'];

    switch (status) {
      case ('CANCELED'):
        return RepositoryStatus.cancelled;
      case ('FAILED'):
        return RepositoryStatus.failed;
      case ('SUCCESS'):
        return RepositoryStatus.success;
    }

    return RepositoryStatus.none;
  }

  Widget repositoriesList(List repositories) {
    return ListView.separated(
        itemBuilder: (BuildContext _context, int index) {
          final dynamic repository = repositories[index];

          return ListRepository(
            username: repository?['group']?['name'] ??
                repository?['namespace']?['name'] ??
                'Unknown',
            name: repository?['name'],
            status: pipelineToStatus(repository?['pipelines']?['nodes']),
            private: repository?['visibility'] == 'private',
            stars: repository?['starCount'] ?? -1,
            forks: repository?['forksCount'] ?? -1,
            pulls: repository?['openIssuesCount'] != null
                ? repository?['mergeRequests']?['count'] ?? -1
                : -1,
            issues: repository?['openIssuesCount'] ?? -1,
          );
        },
        separatorBuilder: (BuildContext _context, int _index) => const Divider(
              height: 0,
              thickness: 1,
            ),
        itemCount: repositories.length);
  }

  @override
  Widget build(BuildContext context) {
    String myReposDocument = '''
      query {
        currentUser {
          username,
          starredProjects {
            nodes {
              name,
              namespace {
                name
              },
              group {
                name
              },
              visibility,
              starCount,
              forksCount,
              openIssuesCount,
              mergeRequests(state: opened) {
                count
              },
              pipelines(first: 1) {
                nodes {
                  status,
                }
              }
            }
          }
        }
      }
    ''';

    return Query(
      options: QueryOptions(document: gql(myReposDocument)),
      builder: (QueryResult<dynamic> result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return ChildRouteScaffold(
              username: 'Error',
              barTitle: 'Starred Repositories',
              body: Center(
                child: Text(result.exception.toString()),
              ));
        }

        if (result.isLoading) {
          return const ChildRouteScaffold(
              username: 'Loading...',
              barTitle: 'Starred Repositories',
              body: Center(
                child: Text('Loading...'),
              ));
        }

        List? repositories =
            result.data?['currentUser']?['projectMemberships']?['nodes'];

        if (repositories == null || repositories.isEmpty) {
          return ChildRouteScaffold(
            username:
                result.data?['currentUser']?['username'] ?? 'Unknown user',
            barTitle: 'Starred Repositories',
            body: const Center(child: Text('No repositories')),
          );
        }

        return ChildRouteScaffold(
          username: result.data?['currentUser']?['username'] ?? 'Unknown user',
          barTitle: 'Starred Repositories',
          body: repositoriesList(repositories),
        );
      },
    );
  }
}
