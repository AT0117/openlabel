import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _kProfileStorageKey = 'openlabel_profile_selections';

/// All selectable dietary restrictions + allergens in the Profile screen.
const profileChipLabels = <String>[
  'Vegan',
  'Vegetarian',
  'Keto',
  'Gluten-Free',
  'Dairy/Lactose',
  'Peanuts',
  'Tree Nuts',
  'Soy',
];

final _secureStorageProvider = Provider<FlutterSecureStorage>(
  (_) => const FlutterSecureStorage(),
);

final profileSelectionProvider =
    AsyncNotifierProvider<ProfileSelectionController, Set<String>>(
  ProfileSelectionController.new,
);

/// Loads/saves the selected profile chips locally using `flutter_secure_storage`.
class ProfileSelectionController extends AsyncNotifier<Set<String>> {
  @override
  Future<Set<String>> build() async {
    final storage = ref.read(_secureStorageProvider);
    final raw = await storage.read(key: _kProfileStorageKey);
    if (raw == null || raw.trim().isEmpty) return <String>{};

    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded.map((e) => e.toString()).toSet();
      }
    } catch (_) {
      // Ignore malformed stored JSON and fall back to empty selections.
    }

    return <String>{};
  }

  Future<void> toggle(String chipLabel) async {
    final current = state.valueOrNull ?? <String>{};
    final next = Set<String>.from(current);

    if (next.contains(chipLabel)) {
      next.remove(chipLabel);
    } else {
      next.add(chipLabel);
    }

    // Update UI immediately for responsiveness, then persist asynchronously.
    state = AsyncData(next);

    final storage = ref.read(_secureStorageProvider);
    await storage.write(
      key: _kProfileStorageKey,
      value: jsonEncode(next.toList()),
    );
  }
}

