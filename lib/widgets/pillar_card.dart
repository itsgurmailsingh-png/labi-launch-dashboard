import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PillarCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final int done;
  final int total;
  final Color color;
  final VoidCallback? onTap;

  const PillarCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.done,
    required this.total,
    required this.color,
    this.onTap,
  });

  @override
  State<PillarCard> createState() => _PillarCardState();
}

class _PillarCardState extends State<PillarCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final pct = widget.total > 0 ? widget.done / widget.total : 0.0;
    final pctInt = (pct * 100).round();

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: fast,
          padding: const EdgeInsets.all(s4),
          decoration: BoxDecoration(
            color: _hovered ? C.bgHover : C.bgSurface,
            borderRadius: BorderRadius.circular(r3),
            border: Border.all(
              color: _hovered ? C.borderSubtle : C.borderMuted,
            ),
          ),
          child: Row(
            children: [
              ArcProgress(
                value: pct,
                color: widget.color,
                size: 52,
                strokeWidth: 4,
                center: Text(
                  '$pctInt%',
                  style: T.bodyXs.copyWith(
                    color: widget.color,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(width: s3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: T.titleSm),
                    const SizedBox(height: 2),
                    Text(widget.subtitle,
                        style: T.bodyXs.copyWith(color: C.textMuted)),
                    const SizedBox(height: 6),
                    Text(
                      '${widget.done} / ${widget.total} done',
                      style: T.bodyXs.copyWith(
                          color: C.textMuted, fontFamily: 'monospace'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
