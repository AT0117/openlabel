import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openlabel/router/app_router.dart';
import 'package:openlabel/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: OpenLabelApp()));
}

class OpenLabelApp extends ConsumerWidget {
  const OpenLabelApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'OpenLabel',
      debugShowCheckedModeBanner: false,
      theme: OpenLabelTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: router,
    );
  }
}
