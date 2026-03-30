import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Riverpod state for the active UI language.
///
/// Requirements:
/// - Must be a `StateProvider<String>` named `languageProvider`
/// - Default is `'en'`
/// - Preference persists via `flutter_secure_storage`
final languageProvider = StateProvider<String>((ref) => 'en');

const _kLanguageStorageKey = 'openlabel_language';

final _secureStorageProvider = Provider<FlutterSecureStorage>(
  (_) => const FlutterSecureStorage(),
);

/// Loads the saved language once and persists changes going forward.
///
/// Watch this provider near the root UI (we also watch it from HomeScreen).
final languagePersistenceProvider = FutureProvider<void>((ref) async {
  final storage = ref.read(_secureStorageProvider);

  // Persist changes whenever the languageProvider updates.
  ref.listen<String>(
    languageProvider,
    (previous, next) {
      // Fire-and-forget: this should never block the UI thread.
      unawaited(
        storage.write(key: _kLanguageStorageKey, value: next),
      );
    },
  );

  final raw = await storage.read(key: _kLanguageStorageKey);
  final normalized = (raw ?? '').trim().toLowerCase();

  const allowed = {'en', 'hi', 'mr'};
  if (allowed.contains(normalized)) {
    ref.read(languageProvider.notifier).state = normalized;
  }
});

