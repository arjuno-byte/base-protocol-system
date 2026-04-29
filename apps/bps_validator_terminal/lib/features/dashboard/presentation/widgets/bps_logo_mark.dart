import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';

class BpsLogoMark extends StatelessWidget {
  const BpsLogoMark({super.key, this.size = 76});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.bpsLogo,
      width: size,
      height: size,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
}
