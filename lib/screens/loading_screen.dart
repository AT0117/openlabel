import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:openlabel/providers/analysis_controller.dart';
import 'package:openlabel/providers/language_provider.dart';
import 'package:openlabel/i18n/translation_service.dart';
import 'package:openlabel/theme/theme.dart';

class LoadingScreen extends ConsumerStatefulWidget {
  const LoadingScreen({super.key});

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen>
    with SingleTickerProviderStateMixin {
  static const _actionStepKeys = <String>[
    'action_step_1',
    'action_step_2',
    'action_step_3',
    'action_step_4',
    'action_step_5',
  ];

  late final AnimationController _pulseController;
  Timer? _timer;
  int _stepIndex = 0;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);

    _timer = Timer.periodic(const Duration(milliseconds: 1200), (_) {
      if (!mounted) return;
      setState(() {
        _stepIndex = (_stepIndex + 1) % _actionStepKeys.length;
      });
      HapticFeedback.lightImpact();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(languagePersistenceProvider);
    final lang = ref.watch(languageProvider);

    ref.listen(analysisControllerProvider, (previous, next) {
      next.when(
        data: (data) {
          if (data != null && !_navigated) {
            _navigated = true;
            context.go('/verdict');
          }
        },
        loading: () {},
        error: (e, st) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Analysis failed: $e'),
              backgroundColor: OpenLabelTheme.electricRed,
            ),
          );
          context.go('/home');
        },
      );
    });

    final step = TranslationService.t(_actionStepKeys[_stepIndex], lang);

    return Scaffold(
      backgroundColor: OpenLabelTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          final t = _pulseController.value;
                          return Container(
                            width: 64,
                            height: 64,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: OpenLabelTheme.surface,
                              border: Border.all(
                                color: OpenLabelTheme.neonGreen
                                    .withValues(alpha: 0.35 + (t * 0.2)),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: OpenLabelTheme.neonGreen.withValues(
                                    alpha: 0.35 + (t * 0.25),
                                  ),
                                  blurRadius: 28,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Transform.scale(
                              scale: 0.92 + (t * 0.14),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 44,
                                    height: 44,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: OpenLabelTheme.neonGreen,
                                      backgroundColor: OpenLabelTheme.surface,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 26),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 260),
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeIn,
                        transitionBuilder: (child, animation) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                        child: Text(
                          step,
                          key: ValueKey(step),
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        TranslationService.t('analyzing_label', lang),
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 18),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: OpenLabelTheme.neonGreen.withValues(alpha: 0.28),
                      blurRadius: 22,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    minHeight: 6,
                    backgroundColor: OpenLabelTheme.surface,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      OpenLabelTheme.neonGreen,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
