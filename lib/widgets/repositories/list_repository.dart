import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gitlab_mobile/icons.dart';

enum RepositoryStatus {
  none,
  success,
  failed,
  cancelled,
}

class ListRepository extends StatelessWidget {
  const ListRepository(
      {Key? key,
      this.username = 'MarekVospel',
      this.name = 'Awesome Project',
      this.status = RepositoryStatus.none})
      : super(key: key);

  final String username;
  final String name;

  final RepositoryStatus status;

  @override
  Widget build(BuildContext context) {
    SvgPicture? icon;

    switch (status) {
      case (RepositoryStatus.success):
        icon = successIcon;
        break;
      case (RepositoryStatus.failed):
        icon = failedIcon;
        break;
      case (RepositoryStatus.cancelled):
        icon = cancelledIcon;
        break;
      default:
        break;
    }

    return ListTile(
      title: Row(
        children: [
          Text('$username / '),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      subtitle: Row(
        children: const [],
      ),
      trailing: icon != null
          ? IconButton(
              icon: icon,
              onPressed: () {},
            )
          : null,
      onTap: () {},
    );
  }
}
