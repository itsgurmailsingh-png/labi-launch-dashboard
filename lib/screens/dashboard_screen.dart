import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import '../models/checklist_item.dart';
import '../theme/app_theme.dart';
import '../widgets/pillar_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/whats_next_card.dart';

class DashboardScreen extends StatelessWidget {
  final ValueChanged<int> onNavigate;
  const DashboardScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(s5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── Hero ──────────────────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(s5),
            decoration: BoxDecoration(
              color: C.bgSurface,
              borderRadius: BorderRadius.circular(r3),
              border: Border.all(color: C.borderMuted),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(
                            color: C.accentMuted,
                            borderRadius: BorderRadius.circular(rFull),
                            border: Border.all(color: C.accent.withAlpha(55)),
                          ),
                          child: Text('v0.1 · Q3 2026',
                              style: T.bodyXs.copyWith(color: C.accent)),
                        ),
                        const SizedBox(width: s2),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(
                            color: C.bgElevated,
                            borderRadius: BorderRadius.circular(rFull),
                            border: Border.all(color: C.borderDefault),
                          ),
                          child: Text('iOS + Android',
                              style: T.bodyXs.copyWith(color: C.textMuted)),
                        ),
                      ]),
                      const SizedBox(height: s2),
                      Text('Protocol Runner Launch',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: C.textPrimary,
                            height: 1.2,
                          )),
                      const SizedBox(height: s1),
                      Text(
                        'Ship the app that lets bench scientists run overlapping\nexperiments without losing track.',
                        style: T.body.copyWith(color: C.textSecondary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: s6),
                // Days to launch
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: s5, vertical: s4),
                  decoration: BoxDecoration(
                    color: C.bgElevated,
                    borderRadius: BorderRadius.circular(r3),
                    border: Border.all(color: C.borderDefault),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${DateTime(2026, 9, 30).difference(DateTime.now()).inDays}',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          color: C.yellow,
                          height: 1,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('days to target',
                          style: T.bodyXs.copyWith(color: C.textMuted)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: s4),

          // ── What's next ───────────────────────────────────────────────────
          FutureBuilder<ChecklistItem?>(
            future: db.getNextAction(),
            builder: (context, snap) {
              return WhatsNextCard(
                item: snap.data,
                onMarkDone: snap.data != null
                    ? () => db.setChecklistDone(snap.data!.id, true)
                    : null,
                onGoToSection: snap.data != null
                    ? () {
                        final cat = snap.data!.category;
                        onNavigate(switch (cat) {
                          'tech' || 'qa' => 2,
                          'ios' || 'android' => 4,
                          'ops' => 5,
                          'mkt' => 8,
                          _ => 0,
                        });
                      }
                    : null,
              );
            },
          ),

          const SizedBox(height: s4),

          // ── Pillars ───────────────────────────────────────────────────────
          Text('LAUNCH READINESS', style: T.label),
          const SizedBox(height: s2),
          StreamBuilder<List<ChecklistItem>>(
            stream: db.watchAllChecklist(),
            builder: (context, snap) {
              final items = snap.data ?? [];
              int techDone  = items.where((i) => (i.category == 'tech' || i.category == 'qa') && i.done == 1).length;
              int techTotal = items.where((i) => i.category == 'tech' || i.category == 'qa').length;
              int procDone  = items.where((i) => (i.category == 'ios' || i.category == 'android' || i.category == 'ops') && i.done == 1).length;
              int procTotal = items.where((i) => i.category == 'ios' || i.category == 'android' || i.category == 'ops').length;
              int prodDone  = items.where((i) => i.category == 'mkt' && i.done == 1).length;
              int prodTotal = items.where((i) => i.category == 'mkt').length;

              return Row(
                children: [
                  Expanded(child: PillarCard(
                    title: 'Technical', subtitle: 'Eng · QA',
                    done: techDone, total: techTotal,
                    color: C.blue, onTap: () => onNavigate(2),
                  )),
                  const SizedBox(width: s3),
                  Expanded(child: PillarCard(
                    title: 'Process', subtitle: 'iOS · Android · Legal',
                    done: procDone, total: procTotal,
                    color: C.yellow, onTap: () => onNavigate(4),
                  )),
                  const SizedBox(width: s3),
                  Expanded(child: PillarCard(
                    title: 'Product', subtitle: 'Milestones · Marketing',
                    done: prodDone, total: prodTotal,
                    color: C.purple, onTap: () => onNavigate(6),
                  )),
                ],
              );
            },
          ),

          const SizedBox(height: s4),

          // ── Stats ─────────────────────────────────────────────────────────
          StreamBuilder<List<ChecklistItem>>(
            stream: db.watchAllChecklist(),
            builder: (_, snap1) => StreamBuilder<List<Milestone>>(
              stream: db.watchAllMilestones(),
              builder: (_, snap2) {
                final items = snap1.data ?? [];
                final miles = snap2.data ?? [];
                final techDone  = items.where((i) => i.category == 'tech' && i.done == 1).length;
                final techTotal = items.where((i) => i.category == 'tech').length;
                final storeDone = items.where((i) => (i.category == 'ios' || i.category == 'android') && i.done == 1).length;
                final storeTotal= items.where((i) => i.category == 'ios' || i.category == 'android').length;
                final msDone    = miles.where((m) => m.done == 1).length;
                final blockers  = items.where((i) => i.tag == 'crit' && i.done == 0).length;

                return Row(children: [
                  Expanded(child: StatCard(
                    label: 'Tech', value: '$techDone/$techTotal',
                    icon: Icons.code_rounded, color: C.blue,
                    sub: '${((techDone/techTotal.clamp(1,999))*100).round()}% complete',
                  )),
                  const SizedBox(width: s3),
                  Expanded(child: StatCard(
                    label: 'Store Steps', value: '$storeDone/$storeTotal',
                    icon: Icons.rocket_launch_outlined, color: C.yellow,
                    sub: 'iOS + Android',
                  )),
                  const SizedBox(width: s3),
                  Expanded(child: StatCard(
                    label: 'Milestones', value: '$msDone/${miles.length}',
                    icon: Icons.flag_outlined, color: C.green,
                  )),
                  const SizedBox(width: s3),
                  Expanded(child: StatCard(
                    label: 'Blockers', value: '$blockers',
                    icon: Icons.warning_amber_rounded,
                    color: blockers > 0 ? C.red : C.green,
                    sub: blockers > 0 ? 'Critical items' : 'Clear!',
                  )),
                ]);
              },
            ),
          ),

          const SizedBox(height: s4),

          // ── Blocker list ──────────────────────────────────────────────────
          _BlockerSection(db: db),
        ],
      ),
    );
  }
}

class _BlockerSection extends StatelessWidget {
  final AppDatabase db;
  const _BlockerSection({required this.db});

  @override
  Widget build(BuildContext context) {
    return Panel(
      label: 'Critical Blockers',
      icon: Icons.warning_amber_rounded,
      child: FutureBuilder<List<ChecklistItem>>(
        future: db.getCriticalBlockers(),
        builder: (context, snap) {
          final blockers = snap.data ?? [];
          if (blockers.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(s4),
              child: Row(children: [
                const Icon(Icons.check_circle_outline, size: 14, color: C.green),
                const SizedBox(width: s2),
                Text('No critical blockers remaining.',
                    style: T.bodySm.copyWith(color: C.green)),
              ]),
            );
          }
          return Column(
            children: blockers.map((b) => Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: s3, vertical: 9),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: C.borderMuted)),
              ),
              child: Row(children: [
                Container(
                  width: 5, height: 5,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: C.red),
                ),
                const SizedBox(width: s3),
                Expanded(child: Text(b.title,
                    style: T.bodySm.copyWith(color: C.textSecondary))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: C.bgElevated,
                    borderRadius: BorderRadius.circular(r1),
                    border: Border.all(color: C.borderDefault),
                  ),
                  child: Text(b.category.toUpperCase(),
                      style: T.mono.copyWith(fontSize: 9)),
                ),
              ]),
            )).toList(),
          );
        },
      ),
    );
  }
}
