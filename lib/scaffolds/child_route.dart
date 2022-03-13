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
                  style: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Repositories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
          titleTextStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
      body: body
    );
  }
}
