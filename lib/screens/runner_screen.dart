import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import '../theme/app_theme.dart';

class RunnerScreen extends StatelessWidget {
  const RunnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(s5),
      child: StreamBuilder<List<RunnerFeature>>(
        stream: db.watchAllRunnerFeatures(),
        builder: (context, snap) {
          final features = snap.data ?? [];
          final done = features.where((f) => f.done == 1).length;
          return Panel(
            label: 'Protocol Runner — Feature Status',
            icon: Icons.play_circle_outline_rounded,
            actions: [
              Text('$done/${features.length}',
                  style: T.mono.copyWith(color: C.textMuted)),
              const SizedBox(width: s2),
              SizedBox(
                width: 64,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(rFull),
                  child: LinearProgressIndicator(
                    value: features.isNotEmpty ? done / features.length : 0,
                    backgroundColor: C.borderDefault,
                    valueColor: const AlwaysStoppedAnimation<Color>(C.accent),
                    minHeight: 3,
                  ),
                ),
              ),
            ],
            child: Column(
              children: features.asMap().entries.map((e) => Column(children: [
                _FeatureTile(
                  feature: e.value,
                  onTap: () => db.cycleRunnerStatus(e.value.id, e.value.status),
                ),
                if (e.key < features.length - 1)
                  const Divider(height: 1, indent: s3, endIndent: s3),
              ])).toList(),
            ),
          );
        },
      ),
    );
  }
}

class _FeatureTile extends StatefulWidget {
  final RunnerFeature feature;
  final VoidCallback onTap;
  const _FeatureTile({required this.feature, required this.onTap});

  @override
  State<_FeatureTile> createState() => _FeatureTileState();
}

class _FeatureTileState extends State<_FeatureTile> {
  bool _hovered = false;

  Color get _iconColor => switch (widget.feature.color) {
    'blue'   => C.blue,
    'green'  => C.green,
    'amber'  => C.yellow,
    'purple' => C.purple,
    _        => C.accent,
  };

  Color get _statusColor => switch (widget.feature.status) {
    'done' => C.green,
    'wip'  => C.yellow,
    _      => C.red,
  };

  String get _statusLabel => switch (widget.feature.status) {
    'done' => 'Done',
    'wip'  => 'In Progress',
    _      => 'To Do',
  };

  @override
  Widget build(BuildContext context) {
    final done = widget.feature.done == 1;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: fast,
          color: _hovered ? C.bgHover : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: s3, vertical: 10),
          child: Row(
            children: [
              // Icon square
              Container(
                width: 34, height: 34,
                decoration: BoxDecoration(
                  color: _iconColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(r2),
                  border: Border.all(color: _iconColor.withAlpha(40)),
                ),
                child: Center(
                  child: Text(widget.feature.icon,
                      style: const TextStyle(fontSize: 15)),
                ),
              ),
              const SizedBox(width: s3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.feature.title,
                      style: T.bodySm.copyWith(
                        color: done ? C.textMuted : C.textPrimary,
                        fontWeight: FontWeight.w500,
                        decoration: done ? TextDecoration.lineThrough : null,
                        decorationColor: C.textMuted,
                      ),
                    ),
                    Text(widget.feature.description, style: T.bodyXs),
                  ],
                ),
              ),
              const SizedBox(width: s3),
              StatusBadge(label: _statusLabel, color: _statusColor),
            ],
          ),
        ),
      ),
    );
  }
}
