import 'package:flutter/material.dart';
import '../scaffolds/child_route.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RepositoriesRoute extends StatelessWidget {
  const RepositoriesRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String getUser = """
      query {
        user(username: "MarekVospel") {
          username,
          starredProjects {
            nodes {
              name,
              group {
                name
              },
              starCount
            }
          }
        }
      }
    """;

    return ChildRouteScaffold(
      username: 'MarekVospel',
      body: SafeArea(
        child: Query(
          options: QueryOptions(
              document: gql(getUser),
            ),
          builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
            if (result.hasException) {
              return Text(result.exception.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              );
            }

            if (result.isLoading) {
              return const Text('Loading',
                style: TextStyle(
                  color: Colors.white,
                ),
              );
            }

            String? username = result.data?['user']?['username'];
            List? starred = result.data?['user']?['starredProjects']?['nodes'];

            if (username == null || starred == null) {
              return const Text('Some data was not delivered...',
                style: TextStyle(
                  color: Colors.white,
                ),
              );
            }

            return ListView.builder(
              itemCount: starred.length,
              itemBuilder: (context, index) {
                final repository = starred[index];
                final group = repository?['group']?['name'];

                String name = repository['name'];

                if (group != null) {
                  name = group + '/' + name;
                } else {
                  name = username + '/' + name;
                }

                name = name + '  ' + repository['starCount'].toString() + '*';

                return Text(name,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                );
              },
            );
          },
        )
      )
    );

/*

    return
*/
  }
}
