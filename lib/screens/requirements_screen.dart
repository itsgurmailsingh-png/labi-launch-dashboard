import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import '../theme/app_theme.dart';

class RequirementsScreen extends StatelessWidget {
  const RequirementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(s5),
      child: StreamBuilder<List<Requirement>>(
        stream: db.watchAllRequirements(),
        builder: (context, snap) {
          final reqs = snap.data ?? [];
          final groups = <String, List<Requirement>>{};
          for (final r in reqs) {
            groups.putIfAbsent(r.groupName, () => []).add(r);
          }
          final done = reqs.where((r) => r.status == 'done').length;
          return Panel(
            label: 'Product Requirements',
            icon: Icons.format_list_bulleted_rounded,
            actions: [
              Text('$done/${reqs.length}',
                  style: T.mono.copyWith(color: C.textMuted)),
            ],
            child: Column(
              children: groups.entries.expand((entry) {
                final gDone = entry.value.where((r) => r.status == 'done').length;
                return [
                  // Group header
                  Container(
                    padding: const EdgeInsets.fromLTRB(s3, 8, s3, 6),
                    color: C.bgElevated,
                    child: Row(children: [
                      Text(entry.key.toUpperCase(), style: T.label),
                      const Spacer(),
                      Text('$gDone/${entry.value.length}',
                          style: T.mono.copyWith(fontSize: 9)),
                    ]),
                  ),
                  const Divider(height: 1),
                  ...entry.value.asMap().entries.map((e) => Column(children: [
                    _ReqRow(
                      req: e.value,
                      onTap: () => db.cycleRequirementStatus(
                          e.value.id, e.value.status),
                    ),
                    if (e.key < entry.value.length - 1)
                      const Divider(height: 1, indent: s3, endIndent: s3),
                  ])),
                  const Divider(height: 1),
                ];
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

class _ReqRow extends StatefulWidget {
  final Requirement req;
  final VoidCallback onTap;
  const _ReqRow({required this.req, required this.onTap});

  @override
  State<_ReqRow> createState() => _ReqRowState();
}

class _ReqRowState extends State<_ReqRow> {
  bool _hovered = false;

  Color get _color => switch (widget.req.status) {
    'done' => C.green,
    'wip'  => C.yellow,
    _      => C.textMuted,
  };

  IconData get _icon => switch (widget.req.status) {
    'done' => Icons.check_circle_outline_rounded,
    'wip'  => Icons.timelapse_rounded,
    _      => Icons.radio_button_unchecked,
  };

  String get _label => switch (widget.req.status) {
    'done' => 'DONE',
    'wip'  => 'WIP',
    _      => 'TODO',
  };

  @override
  Widget build(BuildContext context) {
    final done = widget.req.status == 'done';
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: fast,
          color: _hovered ? C.bgHover : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: s3, vertical: 9),
          child: Row(
            children: [
              Icon(_icon, size: 14, color: _color),
              const SizedBox(width: s2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.req.name,
                      style: T.bodySm.copyWith(
                        color: done ? C.textMuted : C.textSecondary,
                        decoration: done ? TextDecoration.lineThrough : null,
                        decorationColor: C.textMuted,
                      ),
                    ),
                    if (widget.req.note.isNotEmpty)
                      Text(widget.req.note, style: T.bodyXs),
                  ],
                ),
              ),
              const SizedBox(width: s2),
              StatusBadge(label: _label, color: _color),
            ],
          ),
        ),
      ),
    );
  }
}
