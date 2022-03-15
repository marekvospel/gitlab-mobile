import 'package:flutter/material.dart';

class IndexRoute extends StatelessWidget {
  const IndexRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/starred_repositories');
          },
          icon: const Icon(Icons.alt_route),
        ));
  }
}
