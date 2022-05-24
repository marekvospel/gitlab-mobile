import 'package:flutter/material.dart';
import 'package:gitlab_mobile/scaffolds/child_route.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../widgets/repositories/list_repository.dart';

class MyRepositoriesRoute extends StatelessWidget {
  const MyRepositoriesRoute({Key? key}) : super(key: key);

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
    String username = 'marekvospel';

    String starredReposDocument = '''
      query {
        currentUser {
          username,
          projectMemberships {
            nodes {
              project {
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
      }
    ''';

    return ChildRouteScaffold(
      username: username,
      barTitle: 'Starred Repositories',
      body: NotificationListener<OverscrollIndicatorNotification>(        onNotification: (OverscrollIndicatorNotification overscroll) {
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
                result.data?['currentUser']?['projectMemberships']?['nodes'];

            if (repositories == null || repositories.isEmpty) {
              return const Center(
                child: Text('No repositories'),
              );
            }

            return ListView.separated(
              itemCount: repositories.length,
              itemBuilder: (BuildContext _context, int index) => ListRepository(
                username: repositories[index]?['project']?['group']?['name'] ??
                    repositories[index]?['project']?['namespace']?['name'] ??
                    'Unknown',
                name: repositories[index]?['project']?['name'],
                status: pipelineToStatus(
                    repositories[index]?['project']?['pipelines']?['nodes']),
                private:
                    repositories[index]?['project']?['visibility'] == 'private',
                stars: repositories[index]?['project']?['starCount'] ?? -1,
                forks: repositories[index]?['project']?['forksCount'] ?? -1,
                pulls: repositories[index]?['project']?['mergeRequests']
                        ?['count'] ??
                    0,
                issues:
                    repositories[index]?['project']?['openIssuesCount'] ?? -1,
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
