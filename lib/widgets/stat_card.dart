import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String? sub;
  final Color? color;
  final IconData? icon;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.sub,
    this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final col = color ?? C.textSecondary;
    return Container(
      padding: const EdgeInsets.all(s3),
      decoration: BoxDecoration(
        color: C.bgSurface,
        borderRadius: BorderRadius.circular(r3),
        border: Border.all(color: C.borderMuted),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null)
                Icon(icon, size: 12, color: C.textMuted),
              if (icon != null) const SizedBox(width: s1),
              Text(label.toUpperCase(), style: T.label),
            ],
          ),
          const SizedBox(height: s2),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: col,
              height: 1.1,
              fontFamily: 'monospace',
            ),
          ),
          if (sub != null) ...[
            const SizedBox(height: 2),
            Text(sub!, style: T.bodyXs),
          ],
        ],
      ),
    );
  }
}
