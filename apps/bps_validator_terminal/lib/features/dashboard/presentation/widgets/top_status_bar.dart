import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/models/terminal_models.dart';

class TopStatusBar extends StatelessWidget {
  const TopStatusBar({super.key, required this.metrics});

  final List<StatusMetric> metrics;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: metrics
          .map(
            (metric) => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: AppSizes.gap),
                child: _StatusCard(metric: metric),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.metric});

  final StatusMetric metric;

  @override
  Widget build(BuildContext context) {
    final accent = metric.accent ?? AppColors.blue;
    return Container(
      height: 86,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.panel.withAlpha(225),
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppSizes.panelRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            metric.label,
            style: const TextStyle(
              color: AppColors.blue,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            metric.primary,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: accent,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  metric.secondary,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                  ),
                ),
              ),
              if (metric.secondary == 'Connected') ...[
                const SizedBox(width: 8),
                const _OnlineDot(),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _OnlineDot extends StatelessWidget {
  const _OnlineDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 9,
      height: 9,
      decoration: const BoxDecoration(
        color: AppColors.green,
        shape: BoxShape.circle,
      ),
    );
  }
}
