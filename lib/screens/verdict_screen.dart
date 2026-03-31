import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openlabel/models/product_analysis_result.dart';
import 'package:openlabel/providers/analysis_controller.dart';
import 'package:openlabel/theme/theme.dart';
import 'package:share_plus/share_plus.dart';
import 'package:openlabel/i18n/translation_service.dart';
import 'package:openlabel/providers/language_provider.dart';
import 'package:openlabel/services/tts_service.dart';

class VerdictScreen extends ConsumerStatefulWidget {
  const VerdictScreen({super.key});

  @override
  ConsumerState<VerdictScreen> createState() => _VerdictScreenState();
}

class _VerdictScreenState extends ConsumerState<VerdictScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  final ScreenshotController _heroScreenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    ref.read(ttsServiceProvider).stop(ref);
    super.dispose();
  }

  Future<void> _onSharePressed(ProductAnalysisResult result) async {
    HapticFeedback.lightImpact();

    final productName = (result.productName != null && result.productName!.isNotEmpty) 
        ? result.productName! 
        : 'this product';
    final trustLevel = result.trustLevel;
    final overallVerdict = result.overallVerdict;

    final shareText = '''🚨 OpenLabel Alert! 🚨

I just scanned $productName and it scored a $trustLevel Trust Level.

Verdict: $overallVerdict

Stop falling for food fraud. Scan your labels with OpenLabel. #TechJustice #OpenLabel''';

    await Share.share(shareText, subject: 'OpenLabel Verdict for $productName');
  }

  void _showLegalSheet(String text) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.65),
      builder: (ctx) {
        final viewInsets = MediaQuery.viewInsetsOf(ctx);
        final maxH = MediaQuery.sizeOf(ctx).height - viewInsets.bottom;
        final sheetHeight = (maxH * 0.94).clamp(200.0, double.infinity);

        return Container(
          height: sheetHeight,
          decoration: const BoxDecoration(
            color: Color(0xFF0E0E0E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(
              top: BorderSide(color: OpenLabelTheme.border),
              left: BorderSide(color: OpenLabelTheme.border),
              right: BorderSide(color: OpenLabelTheme.border),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Legal draft',
                        style: Theme.of(ctx).textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      icon: const Icon(Icons.close_rounded),
                      color: Colors.white70,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: SelectableText(
                    text.replaceAll('**', '').replaceAll('*', ''),
                    style: GoogleFonts.merriweather(
                      fontSize: 15,
                      height: 1.65,
                      color: const Color(0xFFE5E7EB),
                    ),
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [
                            OpenLabelTheme.neonGreen,
                            Color(0xFF00C853),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: OpenLabelTheme.neonGreen.withValues(alpha: 0.35),
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(text: text));
                            HapticFeedback.mediumImpact();
                            if (ctx.mounted) {
                              ScaffoldMessenger.of(ctx).showSnackBar(
                                const SnackBar(
                                  content: Text('Copied to clipboard'),
                                  backgroundColor: OpenLabelTheme.surface,
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: Text(
                                'Copy to clipboard',
                                style: Theme.of(ctx).textTheme.titleSmall?.copyWith(
                                      color: const Color(0xFF04140A),
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(languagePersistenceProvider);
    final lang = ref.watch(languageProvider);
    final translatedAsync = ref.watch(translatedResultProvider);

    if (translatedAsync.isLoading) {
      return Scaffold(
        backgroundColor: OpenLabelTheme.background,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: OpenLabelTheme.neonGreen),
              const SizedBox(height: 16),
              Text(
                'Translating verdict...',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: OpenLabelTheme.bodyGrey),
              ),
            ],
          ),
        ),
      );
    }

    final result = translatedAsync.valueOrNull;

    if (result == null) {
      return Scaffold(
        backgroundColor: OpenLabelTheme.background,
        body: Center(
          child: Text(
            'No verdict yet.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }

    if (result.isNonEdible == true) {
      return Scaffold(
        backgroundColor: OpenLabelTheme.background,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Stack(
                children: [
                  Center(child: _InvalidTargetCard(result: result)),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => context.go('/home'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final bottomInset = MediaQuery.paddingOf(context).bottom;

    Color resolvedColor;
    if (result.trustLevel.toUpperCase() == 'RED') {
      resolvedColor = OpenLabelTheme.electricRed;
    } else if (result.trustLevel.toUpperCase() == 'YELLOW') {
      resolvedColor = OpenLabelTheme.warningYellow;
    } else {
      resolvedColor = OpenLabelTheme.neonGreen;
    }

    return Scaffold(
      backgroundColor: OpenLabelTheme.background,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Screenshot(
                  controller: _heroScreenshotController,
                  child: _VerdictHero(
                    result: result,
                    themeColor: resolvedColor,
                    pulse: _pulseController,
                    trustLabel: TranslationService.t('trust_score', lang),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(20, 8, 20, 100 + bottomInset),
                    children: [
                      _VerdictHeadlineCard(result: result, themeColor: resolvedColor),
                      const SizedBox(height: 24),
                      Text(
                        'Flags',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      ...result.flags.map((f) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _GlassFlagCard(flag: f),
                          )),
                      if (result.healthierAlternatives != null && result.healthierAlternatives!.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        Text(
                          'Healthier Alternatives',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        ...result.healthierAlternatives!.map((altString) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _AlternativeCard(alt: altString, themeColor: resolvedColor),
                            )),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (result.legalDraftAvailable)
            Positioned(
              left: 20,
              right: 20,
              bottom: 16 + bottomInset,
              child: _TechJusticeButton(
                themeColor: resolvedColor,
                onPressed: () {
                  final text = result.legalDraftText;
                  if (text == null || text.isEmpty) return;
                  _showLegalSheet(text);
                },
                label: TranslationService.t('draft_complaint', lang),
              ),
            ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 6,
            left: 8,
            child: IconButton(
              onPressed: () => context.go('/home'),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              color: Colors.white,
            ),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 6,
            right: 8,
            child: IconButton(
              onPressed: () => _onSharePressed(result),
              icon: const Icon(Icons.share_outlined),
              color: Colors.white,
            ),
          ),
        ],
      ),
    )));
  }
}

class _VerdictHero extends ConsumerWidget {
  const _VerdictHero({
    required this.result,
    required this.themeColor,
    required this.pulse,
    required this.trustLabel,
  });

  final ProductAnalysisResult result;
  final Color themeColor;
  final Animation<double> pulse;
  final String trustLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final h = MediaQuery.sizeOf(context).height * 0.35;
    
    final speedScore = result.trustScore ?? 0.0;

    return SizedBox(
      height: h,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedBuilder(
              animation: pulse,
              builder: (context, child) {
                final t = pulse.value;
                return DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0, -0.9),
                      radius: 1.15 + (t * 0.08),
                      colors: [
                        themeColor.withValues(alpha: 0.55 + t * 0.12),
                        const Color(0xFF1A0508),
                        OpenLabelTheme.background,
                      ],
                      stops: const [0.0, 0.45, 1.0],
                    ),
                  ),
                );
              },
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.0),
                    OpenLabelTheme.background.withValues(alpha: 0.92),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                MediaQuery.paddingOf(context).top + 44,
                20,
                16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Center(
                      child: SpeedometerWidget(
                        score: speedScore, 
                        themeColor: themeColor,
                      ),
                    ),
                  ),
                  Center(child: _TrustPill(score: result.trustLevel, label: trustLabel)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrustPill extends StatelessWidget {
  const _TrustPill({required this.score, required this.label});

  final String score;
  final String label;

  @override
  Widget build(BuildContext context) {
    final s = score.toUpperCase();
    final (Color fg, Color bg) = switch (s) {
      'RED' => (
          Colors.white,
          OpenLabelTheme.electricRed.withValues(alpha: 0.35),
        ),
      'YELLOW' => (
          OpenLabelTheme.warningYellow,
          OpenLabelTheme.warningYellow.withValues(alpha: 0.15),
        ),
      'GREEN' => (
          OpenLabelTheme.neonGreen,
          OpenLabelTheme.neonGreen.withValues(alpha: 0.12),
        ),
      _ => (
          OpenLabelTheme.bodyGrey,
          OpenLabelTheme.surface,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: bg,
        border: Border.all(color: fg.withValues(alpha: 0.35)),
      ),
      child: Text(
        '$label: $s',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: fg,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}

class _GlassFlagCard extends StatelessWidget {
  const _GlassFlagCard({required this.flag});

  final FlagItem flag;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      flag.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: OpenLabelTheme.surface,
                        border: Border.all(color: OpenLabelTheme.border),
                      ),
                      child: Text(
                        flag.severity.toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: OpenLabelTheme.bodyGrey,
                              letterSpacing: 0.8,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                flag.rationale,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (flag.evidence.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Evidence: ${flag.evidence}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: OpenLabelTheme.bodyGrey,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TechJusticeButton extends StatelessWidget {
  const _TechJusticeButton({
    required this.themeColor,
    required this.onPressed,
    required this.label,
  });

  final Color themeColor;
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            themeColor,
            themeColor.withValues(alpha: 0.7),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: themeColor.withValues(alpha: 0.45),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.gavel_rounded, color: Colors.white, size: 24),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VerdictHeadlineCard extends ConsumerWidget {
  const _VerdictHeadlineCard({required this.result, required this.themeColor});

  final ProductAnalysisResult result;
  final Color themeColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = ref.watch(ttsPlayingProvider);

    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: OpenLabelTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: themeColor.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: themeColor.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 56),
            child: Text(
              result.overallVerdict,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                  ),
            ),
          ),
          Positioned(
            top: -8,
            right: -8,
            child: IconButton(
              onPressed: () {
                HapticFeedback.selectionClick();
                if (isPlaying) {
                  ref.read(ttsServiceProvider).stop(ref);
                } else {
                  ref.read(ttsServiceProvider).speakVerdict(result.overallVerdict, ref);
                }
              },
              icon: Icon(
                isPlaying ? Icons.stop_rounded : Icons.volume_up_rounded,
                color: isPlaying ? OpenLabelTheme.warningYellow : themeColor,
              ),
              style: IconButton.styleFrom(
                backgroundColor: isPlaying 
                    ? OpenLabelTheme.warningYellow.withValues(alpha: 0.15)
                    : themeColor.withValues(alpha: 0.15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InvalidTargetCard extends StatelessWidget {
  final ProductAnalysisResult result;
  
  const _InvalidTargetCard({required this.result});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: OpenLabelTheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: OpenLabelTheme.bodyGrey.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: OpenLabelTheme.electricRed.withValues(alpha: 0.05),
            blurRadius: 30,
            spreadRadius: 5,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: OpenLabelTheme.electricRed.withValues(alpha: 0.15),
            ),
            child: const Icon(Icons.do_not_disturb_alt_rounded, size: 64, color: OpenLabelTheme.electricRed),
          ),
          const SizedBox(height: 24),
          Text(
            'Not a Food Product', 
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            result.overallVerdict, 
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: OpenLabelTheme.bodyGrey, height: 1.5), 
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _AlternativeCard extends StatelessWidget {
  const _AlternativeCard({required this.alt, required this.themeColor});

  final String alt;
  final Color themeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: OpenLabelTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: themeColor.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 12, top: 2),
            child: Icon(Icons.psychology_alt_rounded, size: 22, color: OpenLabelTheme.bodyGrey),
          ),
          Expanded(
            child: Text(
              alt,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    height: 1.4,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class SpeedometerWidget extends StatelessWidget {
  const SpeedometerWidget({super.key, required this.score, required this.themeColor});

  final double score; // 0 to 100
  final Color themeColor;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: score),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return CustomPaint(
          size: const Size(160, 90),
          painter: _SpeedometerPainter(value / 100.0, themeColor),
          child: SizedBox(
            width: 160,
            height: 90,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  value.toInt().toString(),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        height: 1.0,
                      ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SpeedometerPainter extends CustomPainter {
  final double percent;
  final Color glowColor;

  _SpeedometerPainter(this.percent, this.glowColor);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14159, 
      3.14159, 
      false,
      bgPaint,
    );

    final activePaint = Paint()
      ..color = glowColor
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 3.14159 * percent.clamp(0.0, 1.0);
    
    final glowPaint = Paint()
      ..color = glowColor.withValues(alpha: 0.6)
      ..strokeWidth = 18
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14159,
      sweepAngle,
      false,
      glowPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3.14159,
      sweepAngle,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _SpeedometerPainter oldDelegate) {
    return oldDelegate.percent != percent || oldDelegate.glowColor != glowColor;
  }
}
