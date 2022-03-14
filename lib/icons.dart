import 'package:flutter_svg/flutter_svg.dart';
import 'package:gitlab_mobile/theme.dart';

SvgPicture successIcon = SvgPicture.asset(
  'assets/icons/success_icon.svg',
  color: GitlabColors.green,
  height: 24,
);

// TODO: make dark in light mode or create cancelledIconDark
SvgPicture cancelledIcon = SvgPicture.asset(
  'assets/icons/cancelled_icon.svg',
  color: GitlabColors.grey[900],
  height: 24,
);

SvgPicture failedIcon = SvgPicture.asset(
  'assets/icons/failed_icon.svg',
  color: GitlabColors.red,
  height: 24,
);
