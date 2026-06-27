import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import '../theme/app_theme.dart';

class TrajectoryScreen extends StatelessWidget {
  const TrajectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(s5),
      child: StreamBuilder<List<ChecklistItem>>(
        stream: db.watchAllChecklist(),
        builder: (_, s1) => StreamBuilder<List<Milestone>>(
          stream: db.watchAllMilestones(),
          builder: (_, s2) => StreamBuilder<List<Requirement>>(
            stream: db.watchAllRequirements(),
            builder: (_, s3) {
              final items = s1.data ?? [];
              final miles = s2.data ?? [];
              final reqs  = s3.data ?? [];

              final techItems = items.where((i) => i.category == 'tech' || i.category == 'qa').toList();
              final procItems = items.where((i) => ['ios','android','ops'].contains(i.category)).toList();
              final mktItems  = items.where((i) => i.category == 'mkt').toList();

              final techDone = techItems.where((i) => i.done == 1).length;
              final procDone = procItems.where((i) => i.done == 1).length;
              final mktDone  = mktItems.where((i) => i.done == 1).length;
              final reqDone  = reqs.where((r) => r.status == 'done').length;
              final mileDone = miles.where((m) => m.done == 1).length;
              final prodDone = mktDone + reqDone + mileDone;
              final prodTotal= mktItems.length + reqs.length + miles.length;

              final overall = (techItems.isEmpty && procItems.isEmpty && prodTotal == 0) ? 0.0
                  : ((techDone + procDone + prodDone) /
                     (techItems.length + procItems.length + prodTotal).clamp(1, 9999));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overall summary
                  Container(
                    padding: const EdgeInsets.all(s4),
                    decoration: BoxDecoration(
                      color: C.bgSurface,
                      borderRadius: BorderRadius.circular(r3),
                      border: Border.all(color: C.borderMuted),
                    ),
                    child: Row(children: [
                      ArcProgress(
                        value: overall,
                        color: overall > 0.8 ? C.green : overall > 0.4 ? C.yellow : C.red,
                        size: 72,
                        strokeWidth: 6,
                        center: Text(
                          '${(overall * 100).round()}%',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: C.textPrimary,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      const SizedBox(width: s5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Overall Launch Readiness', style: T.titleMd),
                            const SizedBox(height: 4),
                            Text(
                              overall < 0.3
                                  ? 'Early stage — focus on engineering first.'
                                  : overall < 0.6
                                      ? 'Making progress — keep shipping.'
                                      : overall < 0.9
                                          ? 'Almost there — clear remaining blockers.'
                                          : 'Ready to launch! 🚀',
                              style: T.body.copyWith(color: C.textSecondary),
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(rFull),
                              child: LinearProgressIndicator(
                                value: overall,
                                backgroundColor: C.borderDefault,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  overall > 0.8 ? C.green : overall > 0.4 ? C.yellow : C.red,
                                ),
                                minHeight: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),

                  const SizedBox(height: s4),

                  // Three pillar detail cards
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _PillarDetail(
                        label: 'Technical', icon: Icons.code_rounded, color: C.blue,
                        done: techDone, total: techItems.length,
                        rows: [
                          _Row('Engineering',
                            items.where((i) => i.category == 'tech' && i.done == 1).length,
                            items.where((i) => i.category == 'tech').length),
                          _Row('QA & Testing',
                            items.where((i) => i.category == 'qa' && i.done == 1).length,
                            items.where((i) => i.category == 'qa').length),
                        ],
                      )),
                      const SizedBox(width: 12),
                      Expanded(child: _PillarDetail(
                        label: 'Process', icon: Icons.rocket_launch_outlined, color: C.yellow,
                        done: procDone, total: procItems.length,
                        rows: [
                          _Row('iOS Submit',
                            items.where((i) => i.category == 'ios' && i.done == 1).length,
                            items.where((i) => i.category == 'ios').length),
                          _Row('Android Submit',
                            items.where((i) => i.category == 'android' && i.done == 1).length,
                            items.where((i) => i.category == 'android').length),
                          _Row('Ops & Legal',
                            items.where((i) => i.category == 'ops' && i.done == 1).length,
                            items.where((i) => i.category == 'ops').length),
                        ],
                      )),
                      const SizedBox(width: 12),
                      Expanded(child: _PillarDetail(
                        label: 'Product', icon: Icons.flag_outlined, color: C.purple,
                        done: prodDone, total: prodTotal,
                        rows: [
                          _Row('Requirements', reqDone, reqs.length),
                          _Row('Marketing', mktDone, mktItems.length),
                          _Row('Milestones', mileDone, miles.length),
                        ],
                      )),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Row {
  final String label;
  final int done;
  final int total;
  const _Row(this.label, this.done, this.total);
}

class _PillarDetail extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final int done;
  final int total;
  final List<_Row> rows;

  const _PillarDetail({
    required this.label, required this.icon, required this.color,
    required this.done, required this.total, required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    final pct = total > 0 ? done / total : 0.0;
    return Panel(
      label: label,
      icon: icon,
      actions: [
        Text('${(pct * 100).round()}%',
            style: T.mono.copyWith(color: color)),
      ],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(s3),
            child: Row(children: [
              ArcProgress(
                value: pct,
                color: color,
                size: 56,
                strokeWidth: 4,
                center: Text(
                  '${(pct * 100).round()}%',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: color,
                      fontFamily: 'monospace'),
                ),
              ),
              const SizedBox(width: s3),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$done of $total complete',
                      style: T.bodySm.copyWith(color: C.textSecondary)),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(rFull),
                    child: LinearProgressIndicator(
                      value: pct,
                      backgroundColor: color.withAlpha(22),
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      minHeight: 4,
                    ),
                  ),
                ],
              )),
            ]),
          ),
          const Divider(height: 1),
          ...rows.map((row) => Container(
            padding: const EdgeInsets.symmetric(horizontal: s3, vertical: 9),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: C.borderMuted)),
            ),
            child: Row(children: [
              Text(row.label,
                  style: T.bodySm.copyWith(color: C.textSecondary)),
              const Spacer(),
              Text('${row.done} / ${row.total}',
                  style: T.mono.copyWith(
                    color: row.done == row.total ? C.green : C.textMuted,
                  )),
            ]),
          )),
        ],
      ),
    );
  }
}
