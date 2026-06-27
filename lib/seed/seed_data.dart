import 'package:drift/drift.dart';
import '../database/database.dart';

Future<void> seedData(AppDatabase db) async {
  // Tech items
  final techItems = [
    ('te1', 'tech', 'Flutter project builds on iOS (release)', 'Xcode archive succeeds, no signing errors', 'crit'),
    ('te2', 'tech', 'Flutter project builds on Android (release)', 'Signed AAB generated, min SDK 21+', 'crit'),
    ('te3', 'tech', 'Protocol step runner — core loop', 'Load → run → step-by-step → complete flow', 'crit'),
    ('te4', 'tech', 'Parallel run management', '2+ runs simultaneously, state preserved per run', 'crit'),
    ('te5', 'tech', 'Step countdown timer', 'Accurate to ±1s, survives app backgrounding', 'crit'),
    ('te6', 'tech', 'Background timer continues when app backgrounded', 'iOS background modes + Android foreground service', 'crit'),
    ('te7', 'tech', 'Push notification on timer end', 'APNs + FCM delivery, vibration fallback', 'crit'),
    ('te8', 'tech', 'Deviation log — freetext per step', 'Persisted locally, included in run record', 'core'),
    ('te9', 'tech', 'Photo attachment on deviation', 'Camera + gallery picker, stored locally', 'core'),
    ('te10', 'tech', '.eln export (full run record)', 'ISA-JSON or ELN ZIP format, share via OS share sheet', 'core'),
    ('te11', 'tech', 'Offline-first data layer', 'All protocol runs work without internet', 'crit'),
    ('te12', 'tech', 'Protocol library integration (3,200+)', 'Browse, search, import CC-BY 4.0 protocols', 'core'),
    ('te13', 'tech', 'Crash analytics (Sentry / Firebase)', 'Integrated and verified in release builds', 'core'),
  ];

  final qaItems = [
    ('qa1', 'qa', 'Full run: load → complete a protocol (iOS)', 'On physical device, not simulator', 'crit'),
    ('qa2', 'qa', 'Full run: load → complete a protocol (Android)', 'On physical device', 'crit'),
    ('qa3', 'qa', 'Parallel run test: 3 simultaneous runs', 'Timer accuracy checked across all', 'crit'),
    ('qa4', 'qa', 'Timer survives phone lock screen (iOS)', 'Timer alert fires when locked', 'crit'),
    ('qa5', 'qa', 'Timer survives phone lock screen (Android)', 'Foreground service stays alive', 'crit'),
    ('qa6', 'qa', '.eln export opens in target apps', 'Test in Zotero, RSpace, or equivalent', 'core'),
    ('qa7', 'qa', 'Beta: 20 scientists complete a full run', 'TestFlight + internal track, collect feedback', 'crit'),
    ('qa8', 'qa', 'Crash rate < 1% in beta', 'Check Firebase / Sentry dashboard', 'core'),
  ];

  // iOS items
  final iosItems = [
    ('i1', 'ios', 'Apple Developer Program enrolled (\$99/yr)', 'Account & Setup', ''),
    ('i2', 'ios', 'Bundle ID registered in App Store Connect', 'Account & Setup', ''),
    ('i3', 'ios', 'Signing certificates & provisioning profiles created', 'Account & Setup', ''),
    ('i4', 'ios', 'App record created in App Store Connect', 'Account & Setup', ''),
    ('i5', 'ios', 'Release build archived via Xcode', 'Build & Binary', ''),
    ('i6', 'ios', 'Binary uploaded to App Store Connect', 'Build & Binary', ''),
    ('i7', 'ios', 'TestFlight internal test passed (20 testers min)', 'Build & Binary', ''),
    ('i8', 'ios', 'No HTTPS/ATS exceptions (or justified)', 'Build & Binary', ''),
    ('i9', 'ios', 'App name & subtitle (max 30 chars)', 'Store Listing', ''),
    ('i10', 'ios', 'Description (up to 4000 chars)', 'Store Listing', ''),
    ('i11', 'ios', 'Keywords (100 chars): lab protocol, bench science, ELN', 'Store Listing', ''),
    ('i12', 'ios', 'Screenshots (6.7" iPhone + 12.9" iPad)', 'Store Listing', ''),
    ('i13', 'ios', 'App preview video (optional, 30s)', 'Store Listing', ''),
    ('i14', 'ios', 'App icon (1024×1024 PNG, no alpha)', 'Store Listing', ''),
    ('i15', 'ios', 'Category: Medical or Productivity', 'Store Listing', ''),
    ('i16', 'ios', 'Privacy policy URL live & accessible', 'Store Listing', ''),
    ('i17', 'ios', 'Age rating questionnaire completed', 'Review Prep', ''),
    ('i18', 'ios', 'Usage description strings for all permissions', 'Review Prep', ''),
    ('i19', 'ios', 'Demo account/instructions for reviewer', 'Review Prep', ''),
    ('i20', 'ios', 'Submit for App Review', 'Review Prep', ''),
  ];

  // Android items
  final androidItems = [
    ('a1', 'android', 'Google Play Developer account (\$25 one-time)', 'Account & Setup', ''),
    ('a2', 'android', 'App created in Play Console', 'Account & Setup', ''),
    ('a3', 'android', 'Release signing key created (Play App Signing)', 'Account & Setup', ''),
    ('a4', 'android', 'Signed release AAB generated (flutter build appbundle --release)', 'Build & Binary', ''),
    ('a5', 'android', 'Target API level ≥35 (Android 15)', 'Build & Binary', ''),
    ('a6', 'android', 'Internal testing track tested', 'Build & Binary', ''),
    ('a7', 'android', 'Closed testing (beta) with real users, ≥20 testers', 'Build & Binary', ''),
    ('a8', 'android', 'App title & short description', 'Store Listing', ''),
    ('a9', 'android', 'Full description (up to 4000 chars)', 'Store Listing', ''),
    ('a10', 'android', 'Screenshots (phone + 7" & 10" tablet)', 'Store Listing', ''),
    ('a11', 'android', 'Feature graphic (1024×500 JPG/PNG)', 'Store Listing', ''),
    ('a12', 'android', 'App icon (512×512 PNG)', 'Store Listing', ''),
    ('a13', 'android', 'Privacy policy URL live', 'Store Listing', ''),
    ('a14', 'android', 'Category: Medical or Productivity', 'Store Listing', ''),
    ('a15', 'android', 'Content rating questionnaire (IARC)', 'Review Prep', ''),
    ('a16', 'android', 'Data safety section completed', 'Review Prep', ''),
    ('a17', 'android', 'Permissions justified in store listing', 'Review Prep', ''),
    ('a18', 'android', 'Submit for production review', 'Review Prep', ''),
  ];

  final opsItems = [
    ('o1', 'ops', 'Privacy policy drafted, reviewed, and published', 'URL: getlabi.app/privacy', 'crit'),
    ('o2', 'ops', 'Terms of service published', 'Covers CC-BY protocol licensing, acceptable use', 'crit'),
    ('o3', 'ops', 'Data deletion: users can delete account + all data', 'GDPR / App Store requirement', 'crit'),
    ('o4', 'ops', 'Protocol license compliance audit complete', 'CrossRef DOI verification — all 3,200+ protocols CC-BY confirmed', 'crit'),
    ('o5', 'ops', 'Support email live & monitored', 'hello@getlabi.app or Intercom/Crisp', 'core'),
    ('o6', 'ops', 'Domain & SSL (getlabi.app) active', 'HTTPS, auto-renew, fast CDN', 'core'),
    ('o7', 'ops', 'Analytics: anonymous, opt-in only', 'PostHog / Mixpanel — no PII by default', 'core'),
  ];

  final mktItems = [
    ('m1', 'mkt', 'Waitlist collected and segmented', 'Tag scientists vs lab managers, institution type', 'core'),
    ('m2', 'mkt', 'Launch email sequence written (Day 0, 7, 30)', 'Onboarding flow: import first protocol, complete first run', 'core'),
    ('m3', 'mkt', 'App Store screenshots + preview video', '5 iPhone 6.7" + iPad 12.9", 30s preview video', 'crit'),
    ('m4', 'mkt', 'App Store / Play Store description copy', 'Keywords: lab protocol, bench science, ELN, timer', 'crit'),
    ('m5', 'mkt', 'Product Hunt launch assets ready', 'Gallery, tagline, maker comment, 250-char description', 'nice'),
    ('m6', 'mkt', 'Reddit outreach plan', 'r/labrats, r/biology, r/chemistry — authentic story-first', 'nice'),
    ('m7', 'mkt', 'Press kit at getlabi.app/press', 'Logo, screenshots, fact sheet, founder quote', 'nice'),
  ];

  for (final item in [...techItems, ...qaItems]) {
    await db.insertChecklistItem(ChecklistItemsCompanion(
      id: Value(item.$1),
      category: Value(item.$2),
      title: Value(item.$3),
      meta: Value(item.$4),
      tag: Value(item.$5),
    ));
  }

  for (final item in [...iosItems, ...androidItems]) {
    await db.insertChecklistItem(ChecklistItemsCompanion(
      id: Value(item.$1),
      category: Value(item.$2),
      title: Value(item.$3),
      meta: Value(item.$4),
      tag: Value(item.$5),
    ));
  }

  for (final item in [...opsItems, ...mktItems]) {
    await db.insertChecklistItem(ChecklistItemsCompanion(
      id: Value(item.$1),
      category: Value(item.$2),
      title: Value(item.$3),
      meta: Value(item.$4),
      tag: Value(item.$5),
    ));
  }

  // Milestones
  final milestonesData = [
    ('ms1', 'Protocol runner end-to-end on device', 'A scientist can load, run, and complete any protocol with timers.', '2026-07-15', 'overdue', 'te3,te4,te5,qa1,qa2'),
    ('ms2', 'Deviation logging + .eln export working', 'Run records exportable as .eln with deviations and photos.', '2026-07-31', 'overdue', 'te8,te9,te10'),
    ('ms3', 'Protocol library browseable in-app', 'All 3,200+ CC-BY protocols searchable and importable.', '2026-08-10', 'soon', 'te12'),
    ('ms4', 'Beta: 20 scientists complete a full run', 'TestFlight + internal track, real lab feedback collected.', '2026-08-20', 'soon', 'qa7,i7,a7'),
    ('ms5', 'iOS + Android submissions sent', 'Both apps submitted for store review.', '2026-08-28', 'pending', 'i20,a18'),
    ('ms6', 'Both apps approved and live in stores', 'App Store + Play Store approvals received.', '2026-09-10', 'pending', 'i20,a18'),
    ('ms7', 'Public launch: waitlist activated', 'Email sent to waitlist, Product Hunt posted.', '2026-09-15', 'pending', 'm1,m2'),
    ('ms8', '100 scientists running protocols in Labi', 'First real traction signal. Track in analytics.', '2026-09-30', 'pending', 'o7'),
  ];

  for (final m in milestonesData) {
    await db.insertMilestone(MilestonesCompanion(
      id: Value(m.$1),
      title: Value(m.$2),
      description: Value(m.$3),
      date: Value(m.$4),
      status: Value(m.$5),
      linkedIds: Value(m.$6),
    ));
  }

  // Requirements
  final requirementsData = [
    ('r1', 'Protocol Runner', 'Load any protocol from library', '', 'todo'),
    ('r2', 'Protocol Runner', 'Execute steps sequentially with persistent state', '', 'todo'),
    ('r3', 'Protocol Runner', 'Per-step countdown timer (accurate ±1s)', '', 'todo'),
    ('r4', 'Protocol Runner', 'Timer alert when backgrounded / screen locked', 'iOS background modes, Android foreground service', 'todo'),
    ('r5', 'Protocol Runner', 'Mark step complete / skip', '', 'todo'),
    ('r6', 'Protocol Runner', 'Add notes per step', '', 'todo'),
    ('r7', 'Parallel Runs', 'Start 2+ runs simultaneously', '', 'todo'),
    ('r8', 'Parallel Runs', 'Switch between runs without state loss', '', 'todo'),
    ('r9', 'Parallel Runs', 'Independent timers per run in background', '', 'todo'),
    ('r10', 'Parallel Runs', 'Active runs overview', 'which run, what\'s next', 'todo'),
    ('r11', 'Deviation Logging', 'Log deviation on any step (freetext)', '', 'todo'),
    ('r12', 'Deviation Logging', 'Attach photo from camera or gallery', '', 'todo'),
    ('r13', 'Deviation Logging', 'Deviation timestamped and shown in run summary', '', 'todo'),
    ('r14', '.eln Export', 'Export full run as .eln file', 'ELN ZIP or ISA-JSON', 'todo'),
    ('r15', '.eln Export', 'Deviations and photos included in export', '', 'todo'),
    ('r16', '.eln Export', 'Share via OS share sheet / Android intent', '', 'todo'),
    ('r17', 'Protocol Library', 'Browse 3,200+ CC-BY 4.0 protocols', 'Data ingested, UI pending', 'wip'),
    ('r18', 'Protocol Library', 'Search by name / category / keyword', 'Basic search done', 'wip'),
    ('r19', 'Protocol Library', 'Filter by duration, organism, technique', '', 'todo'),
    ('r20', 'Protocol Library', 'Offline cache of imported protocols', '', 'todo'),
    ('r21', 'Infrastructure', 'Offline-first data layer', '', 'todo'),
    ('r22', 'Infrastructure', 'Crash reporting (Sentry / Firebase)', '', 'todo'),
    ('r23', 'Infrastructure', 'Push notification delivery (FCM + APNs)', '', 'todo'),
    ('r24', 'Infrastructure', 'Analytics (anonymous, opt-in)', '', 'todo'),
  ];

  for (final r in requirementsData) {
    await db.insertRequirement(RequirementsCompanion(
      id: Value(r.$1),
      groupName: Value(r.$2),
      name: Value(r.$3),
      note: Value(r.$4),
      status: Value(r.$5),
    ));
  }

  // Runner features
  final runnerData = [
    ('rf1', 'Protocol step-by-step runner', 'Core loop: load → run → complete', '▷', 'blue', 'todo'),
    ('rf2', 'Parallel run dock', 'Switch between 2+ active runs with independent state', '⇄', 'blue', 'todo'),
    ('rf3', 'Step countdown timer', 'Visual countdown, vibration + push on end', '⏱', 'amber', 'todo'),
    ('rf4', 'Deviation logging', 'Per-step notes + camera attachment', '✎', 'purple', 'todo'),
    ('rf5', 'Protocol library (3,200+)', 'CC-BY browse, search, one-tap import', '📚', 'green', 'wip'),
    ('rf6', '.eln export', 'Full run record exported as ELN file', '↓', 'blue', 'todo'),
    ('rf7', 'Offline mode', 'Full run capability without internet', '⊘', 'amber', 'todo'),
    ('rf8', 'Run history', 'Past runs, completion stats, searchable', '◷', 'purple', 'todo'),
    ('rf9', 'Onboarding wizard', '≤3 screens from install to first protocol run', '✦', 'green', 'todo'),
  ];

  for (final rf in runnerData) {
    await db.insertRunnerFeature(RunnerFeaturesCompanion(
      id: Value(rf.$1),
      title: Value(rf.$2),
      description: Value(rf.$3),
      icon: Value(rf.$4),
      color: Value(rf.$5),
      status: Value(rf.$6),
    ));
  }
}
