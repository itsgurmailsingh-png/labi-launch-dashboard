import 'package:flutter/material.dart';
import '../database/database.dart';
import '../models/checklist_item.dart';
import '../theme/app_theme.dart';

class ChecklistTile extends StatefulWidget {
  final ChecklistItem item;
  final VoidCallback onToggle;

  const ChecklistTile({super.key, required this.item, required this.onToggle});

  @override
  State<ChecklistTile> createState() => _ChecklistTileState();
}

class _ChecklistTileState extends State<ChecklistTile> {
  bool _hovered = false;

  Color get _tagColor => switch (widget.item.tag) {
    'crit' => C.red,
    'core' => C.blue,
    'nice' => C.textMuted,
    _      => C.textMuted,
  };

  String get _tagLabel => switch (widget.item.tag) {
    'crit' => 'CRIT',
    'core' => 'CORE',
    'nice' => 'NICE',
    _      => '',
  };

  @override
  Widget build(BuildContext context) {
    final done = widget.item.isDone;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onToggle,
        child: AnimatedContainer(
          duration: fast,
          color: _hovered ? C.bgHover : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: s3, vertical: 9),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Check indicator
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: AnimatedContainer(
                  duration: fast,
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: done ? C.green : Colors.transparent,
                    borderRadius: BorderRadius.circular(r1 + 1),
                    border: Border.all(
                      color: done ? C.green : C.borderSubtle,
                      width: 1.5,
                    ),
                  ),
                  child: done
                      ? const Icon(Icons.check, size: 10, color: C.bgBase)
                      : null,
                ),
              ),
              const SizedBox(width: s2),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.title,
                      style: T.bodySm.copyWith(
                        color: done ? C.textMuted : C.textPrimary,
                        decoration: done ? TextDecoration.lineThrough : null,
                        decorationColor: C.textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (widget.item.meta.isNotEmpty &&
                        widget.item.meta != 'Account & Setup' &&
                        widget.item.meta != 'Build & Binary' &&
                        widget.item.meta != 'Store Listing' &&
                        widget.item.meta != 'Review Prep') ...[
                      const SizedBox(height: 1),
                      Text(widget.item.meta,
                          style: T.bodyXs.copyWith(color: C.textMuted)),
                    ],
                  ],
                ),
              ),
              // Tag
              if (widget.item.tag.isNotEmpty && !done) ...[
                const SizedBox(width: s2),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: _tagColor.withAlpha(22),
                    borderRadius: BorderRadius.circular(r1),
                    border: Border.all(color: _tagColor.withAlpha(55)),
                  ),
                  child: Text(
                    _tagLabel,
                    style: T.bodyXs.copyWith(
                        color: _tagColor, fontWeight: FontWeight.w600, fontSize: 9),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
