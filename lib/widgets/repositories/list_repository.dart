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
  const ListRepository({
    Key? key,
    this.username = 'MarekVospel',
    this.name = 'Awesome Project',
    this.private = false,
    this.status = RepositoryStatus.none,
    this.stars = 0,
    this.forks = 0,
    this.pulls = 0,
    this.issues = 0,
  }) : super(key: key);

  final String username;
  final String name;
  final bool private;

  final RepositoryStatus status;
  final int stars;
  final int forks;
  final int pulls;
  final int issues;

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
        icon = Theme.of(context).brightness == Brightness.dark
            ? cancelledIconDark
            : cancelledIcon;
        break;
      default:
        break;
    }

    return ListTile(
      title: Row(
        children: [
          Text('$username / '),
          Text(
            '$name ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          private ? lockIcon : const Text(''),
        ],
      ),
      subtitle: Row(
        children: [
          Row(
            children: [
              starIcon,
              const SizedBox(width: 4),
              Text('$stars'),
            ],
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              forkIcon,
              const SizedBox(width: 4),
              Text('$forks'),
            ],
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              gitMergeIcon,
              const SizedBox(width: 4),
              Text('$pulls'),
            ],
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              issuesIcon,
              const SizedBox(width: 4),
              Text('$issues'),
            ],
          ),
        ],
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
