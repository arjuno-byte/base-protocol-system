import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';

class SectionColumn extends StatelessWidget {
  const SectionColumn({super.key, required this.rows});

  final List<List<Widget>> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < rows.length; index++) ...[
          Expanded(child: SectionRow(children: rows[index])),
          if (index != rows.length - 1) const SizedBox(height: AppSizes.gap),
        ],
      ],
    );
  }
}

class SectionRow extends StatelessWidget {
  const SectionRow({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 0; index < children.length; index++) ...[
          Expanded(child: children[index]),
          if (index != children.length - 1) const SizedBox(width: AppSizes.gap),
        ],
      ],
    );
  }
}
