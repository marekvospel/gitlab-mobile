import 'package:flutter/material.dart';

class ChildRouteScaffold extends StatelessWidget {
  const ChildRouteScaffold({Key? key, this.username = 'marekvospel', this.barTitle = 'Repositories', required this.body}) : super(key: key);

  final String username;
  final String barTitle;

  final Widget body;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  username,
                  style: Theme.of(context).textTheme.bodySmall
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Repositories',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      body: body
    );
  }
}
