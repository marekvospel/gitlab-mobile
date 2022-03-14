import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gitlab_mobile/theme.dart';

class ListRepository extends StatefulWidget {
  const ListRepository({Key? key, this.username = 'MarekVospel'})
      : super(key: key);

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
      subtitle: Row(
        children: const [],
      ),
      trailing: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/success_icon.svg',
          color: GitlabColors.green[500],
          height: 24,
        ),
        onPressed: () {},
      ),
      onTap: () {},
    );
  }
}
