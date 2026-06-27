import 'package:flutter/material.dart';
import '../database/database.dart';
import '../models/checklist_item.dart';
import '../theme/app_theme.dart';

class WhatsNextCard extends StatelessWidget {
  final ChecklistItem? item;
  final VoidCallback? onMarkDone;
  final VoidCallback? onGoToSection;

  const WhatsNextCard({
    super.key,
    required this.item,
    this.onMarkDone,
    this.onGoToSection,
  });

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: s4, vertical: s3),
        decoration: BoxDecoration(
          color: C.greenMuted,
          borderRadius: BorderRadius.circular(r3),
          border: Border.all(color: C.green.withAlpha(40)),
        ),
        child: Row(children: [
          Icon(Icons.check_circle_outline_rounded, size: 14, color: C.green),
          const SizedBox(width: s2),
          Text('All critical items complete — ready to submit!',
              style: T.bodySm.copyWith(color: C.green)),
        ]),
      );
    }

    return Container(
      padding: const EdgeInsets.all(s4),
      decoration: BoxDecoration(
        color: C.bgElevated,
        borderRadius: BorderRadius.circular(r3),
        border: Border.all(color: C.borderDefault),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    width: 5, height: 5,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: C.yellow),
                  ),
                  const SizedBox(width: s2),
                  Text('NEXT UP', style: T.label.copyWith(color: C.yellow)),
                ]),
                const SizedBox(height: 6),
                Text(item!.title,
                    style: T.titleMd.copyWith(color: C.textPrimary)),
                if (item!.meta.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(item!.meta, style: T.bodyXs),
                ],
              ],
            ),
          ),
          const SizedBox(width: s4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _ActionBtn(
                label: 'Mark done',
                color: C.green,
                onTap: onMarkDone,
              ),
              const SizedBox(height: s2),
              _ActionBtn(
                label: 'Go to section →',
                color: C.accent,
                onTap: onGoToSection,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatefulWidget {
  final String label;
  final Color color;
  final VoidCallback? onTap;
  const _ActionBtn({required this.label, required this.color, this.onTap});

  @override
  State<_ActionBtn> createState() => _ActionBtnState();
}

class _ActionBtnState extends State<_ActionBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: fast,
          padding: const EdgeInsets.symmetric(horizontal: s3, vertical: 6),
          decoration: BoxDecoration(
            color: _hovered
                ? widget.color.withAlpha(28)
                : widget.color.withAlpha(14),
            borderRadius: BorderRadius.circular(r2),
            border: Border.all(color: widget.color.withAlpha(55)),
          ),
          child: Text(widget.label,
              style: T.bodyXs.copyWith(
                  color: widget.color, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
