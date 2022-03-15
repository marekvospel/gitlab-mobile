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

  @override
  Widget build(BuildContext context) {
    String username = 'MarekVospel';

    String starredReposDocument = '''
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
              fullPath,
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

    return ChildRouteScaffold(
      username: username,
      barTitle: 'Starred Repositories',
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: Query(
          options: QueryOptions(document: gql(starredReposDocument)),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Center(
                child: Text(result.exception.toString()),
              );
            }

            if (result.isLoading) {
              return const Center(
                child: Text('Loading...'),
              );
            }

            List? repositories =
                result.data?['currentUser']?['starredProjects']?['nodes'];

            if (repositories == null || repositories.isEmpty) {
              return const Center(
                child: Text('No repositories'),
              );
            }

            return ListView.separated(
              itemCount: repositories.length,
              itemBuilder: (BuildContext _context, int index) => ListRepository(
                username: repositories[index]?['group']?['name'] ??
                    repositories[index]?['namespace']?['name'] ??
                    'Unknown',
                name: repositories[index]?['name'],
                status: pipelineToStatus(
                    repositories[index]?['pipelines']?['nodes']),
                private: repositories[index]?['visibility'] == 'private',
                stars: repositories[index]?['starCount'] ?? 69,
                forks: repositories[index]?['forksCount'] ?? 69,
                pulls: repositories[index]?['mergeRequests']?['count'] ?? 69,
                issues: repositories[index]?['openIssuesCount'] ?? 69,
              ),
              separatorBuilder: (BuildContext _context, int _index) =>
                  const Divider(
                height: 0,
                thickness: 1,
              ),
            );
          },
        ),
      ),
    );
  }
}
