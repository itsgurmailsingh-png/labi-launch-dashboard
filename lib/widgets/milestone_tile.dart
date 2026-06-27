import 'package:flutter/material.dart';
import '../database/database.dart';
import '../models/milestone.dart';
import '../theme/app_theme.dart';

class MilestoneTile extends StatefulWidget {
  final Milestone milestone;
  final bool isLast;
  final VoidCallback onToggle;

  const MilestoneTile({
    super.key,
    required this.milestone,
    required this.isLast,
    required this.onToggle,
  });

  @override
  State<MilestoneTile> createState() => _MilestoneTileState();
}

class _MilestoneTileState extends State<MilestoneTile> {
  bool _hovered = false;

  Color get _statusColor {
    if (widget.milestone.isDone) return C.green;
    return switch (widget.milestone.status) {
      'overdue' => C.red,
      'soon'    => C.yellow,
      _         => C.textMuted,
    };
  }

  String get _statusLabel {
    if (widget.milestone.isDone) return 'Done';
    return switch (widget.milestone.status) {
      'overdue' => 'Overdue',
      'soon'    => 'Soon',
      _         => 'Pending',
    };
  }

  @override
  Widget build(BuildContext context) {
    final done = widget.milestone.isDone;
    final color = _statusColor;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline column
          SizedBox(
            width: 28,
            child: Column(
              children: [
                const SizedBox(height: 14),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: done ? C.green : C.bgElevated,
                    border: Border.all(color: color, width: 1.5),
                  ),
                  child: done
                      ? const Icon(Icons.check, size: 6, color: C.bgBase)
                      : null,
                ),
                if (!widget.isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      color: C.borderDefault,
                    ),
                  ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: s4, right: s3),
              child: MouseRegion(
                onEnter: (_) => setState(() => _hovered = true),
                onExit:  (_) => setState(() => _hovered = false),
                child: GestureDetector(
                  onTap: widget.onToggle,
                  child: AnimatedContainer(
                    duration: fast,
                    padding: const EdgeInsets.all(s3),
                    decoration: BoxDecoration(
                      color: _hovered ? C.bgHover : C.bgElevated,
                      borderRadius: BorderRadius.circular(r3),
                      border: Border.all(
                        color: done
                            ? C.green.withAlpha(40)
                            : _hovered
                                ? C.borderSubtle
                                : C.borderMuted,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.milestone.title,
                                style: T.titleSm.copyWith(
                                  color: done ? C.textMuted : C.textPrimary,
                                  decoration:
                                      done ? TextDecoration.lineThrough : null,
                                  decorationColor: C.textMuted,
                                ),
                              ),
                            ),
                            const SizedBox(width: s2),
                            StatusBadge(label: _statusLabel, color: color),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(widget.milestone.description,
                            style: T.bodyXs.copyWith(color: C.textMuted)),
                        const SizedBox(height: s2),
                        Row(
                          children: [
                            Icon(Icons.calendar_today_outlined,
                                size: 10, color: C.textMuted),
                            const SizedBox(width: 4),
                            Text(widget.milestone.date, style: T.mono),
                            const Spacer(),
                            // Linked ID chips
                            ...widget.milestone.linkedIdList.take(4).map(
                              (id) => Container(
                                margin: const EdgeInsets.only(left: 3),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2),
                                decoration: BoxDecoration(
                                  color: C.bgBase,
                                  borderRadius: BorderRadius.circular(r1),
                                  border: Border.all(color: C.borderDefault),
                                ),
                                child: Text(id, style: T.mono),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
