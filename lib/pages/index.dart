import 'package:flutter/material.dart';

class IndexRoute extends StatelessWidget {
  const IndexRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: ListView(children: [
          ListTile(
            title: const Text('My repositories'),
            onTap: () {
              Navigator.pushNamed(context, '/repositories/my');
            },
          ),
          ListTile(
            title: const Text('Starred repositories'),
            onTap: () {
              Navigator.pushNamed(context, '/repositories/starred');
            },
          ),
          ListTile(
            title: const Text('Login'),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          )
        ]));
  }
}
