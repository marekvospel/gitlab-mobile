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
    this.stars = -1,
    this.forks = -1,
    this.pulls = -1,
    this.issues = -1,
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
    SvgPicture? ciStatusIcon;

    switch (status) {
      case (RepositoryStatus.success):
        ciStatusIcon = successIcon;
        break;
      case (RepositoryStatus.failed):
        ciStatusIcon = failedIcon;
        break;
      case (RepositoryStatus.cancelled):
        ciStatusIcon = Theme.of(context).brightness == Brightness.dark
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
          stars >= 0
              ? Row(
                  children: [
                    starIcon,
                    const SizedBox(width: 4),
                    Text('$stars'),
                  ],
                )
              : Row(),
          SizedBox(width: stars >= 0 ? 8 : 0),
          forks >= 0
              ? Row(
                  children: [
                    forkIcon,
                    const SizedBox(width: 4),
                    Text('$forks'),
                  ],
                )
              : Row(),
          SizedBox(width: forks >= 0 ? 8 : 0),
          pulls >= 0
              ? Row(
                  children: [
                    gitMergeIcon,
                    const SizedBox(width: 4),
                    Text('$pulls'),
                  ],
                )
              : Row(),
          SizedBox(width: pulls >= 0 ? 8 : 0),
          issues >= 0
              ? Row(
                  children: [
                    issuesIcon,
                    const SizedBox(width: 4),
                    Text('$issues'),
                  ],
                )
              : Row(),
        ],
      ),
      trailing: ciStatusIcon != null
          ? IconButton(
              icon: ciStatusIcon,
              onPressed: () {},
            )
          : null,
      onTap: () {},
    );
  }
}
