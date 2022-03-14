import 'package:flutter/material.dart';

class ListRepository extends StatefulWidget {
  const ListRepository({ Key? key, this.username = 'MarekVospel' }) : super(key: key);

  final String username;

  @override
  State<ListRepository> createState() => _ListRepositoryState();

}

class _ListRepositoryState extends State<ListRepository> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text('${widget.username} / '),
          const Text(
            'Awesome project',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      onTap: () {},
    );
  }
}
