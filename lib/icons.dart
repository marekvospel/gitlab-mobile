import 'package:flutter_svg/flutter_svg.dart';
import 'package:gitlab_mobile/theme.dart';

SvgPicture successIcon = SvgPicture.asset(
  'assets/icons/success_icon.svg',
  color: GitlabColors.green,
  height: 24,
);

SvgPicture cancelledIcon = SvgPicture.asset(
  'assets/icons/cancelled_icon.svg',
  color: GitlabColors.grey[50],
  height: 24,
);

SvgPicture cancelledIconDark = SvgPicture.asset(
  'assets/icons/cancelled_icon.svg',
  color: GitlabColors.grey[900],
  height: 24,
);

SvgPicture failedIcon = SvgPicture.asset(
  'assets/icons/failed_icon.svg',
  color: GitlabColors.red,
  height: 24,
);

SvgPicture lockIcon = SvgPicture.asset(
  'assets/icons/lock_icon.svg',
  color: GitlabColors.grey,
  height: 16,
);

SvgPicture starIcon = SvgPicture.asset(
  'assets/icons/star_icon.svg',
  color: GitlabColors.grey,
  height: 14,
);

SvgPicture forkIcon = SvgPicture.asset(
  'assets/icons/fork_icon.svg',
  color: GitlabColors.grey,
  height: 14,
);

SvgPicture gitMergeIcon = SvgPicture.asset(
  'assets/icons/git_merge_icon.svg',
  color: GitlabColors.grey,
  height: 14,
);

SvgPicture issuesIcon = SvgPicture.asset(
  'assets/icons/issues_icon.svg',
  color: GitlabColors.grey,
  height: 14,
);
