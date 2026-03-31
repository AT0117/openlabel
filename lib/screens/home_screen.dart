import 'dart:ui';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:openlabel/providers/analysis_controller.dart';
import 'package:openlabel/providers/language_provider.dart';
import 'package:openlabel/i18n/translation_service.dart';
import 'package:openlabel/theme/theme.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _urlController = TextEditingController();
  final _urlFocus = FocusNode();
  final _picker = ImagePicker();

  late final AnimationController _bounceController;
  late final Animation<double> _bounceScale;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _bounceScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.96).chain(CurveTween(curve: Curves.easeIn)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.96, end: 1.02).chain(CurveTween(curve: Curves.easeOut)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.02, end: 1.0).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 30,
      ),
    ]).animate(_bounceController);
    _urlFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _urlController.dispose();
    _urlFocus.dispose();
    super.dispose();
  }

  Future<void> _onScanTap() async {
    await _bounceController.forward(from: 0);
    if (!mounted) return;
    HapticFeedback.lightImpact();

    ImageSource? source;

    if (kIsWeb) {
      source = ImageSource.gallery;
    } else {
      source = await showModalBottomSheet<ImageSource>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (ctx) {
          final bottom = MediaQuery.paddingOf(ctx).bottom;
          return Material(
            color: OpenLabelTheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 16 + bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  Text(
                    'Add label photos',
                    style: Theme.of(ctx).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose camera or gallery. You’ll pick front, then back.',
                    style: Theme.of(ctx).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  _SourceOptionTile(
                    icon: Icons.photo_camera_rounded,
                    title: 'Camera',
                    subtitle: 'Capture two photos in a row',
                    onTap: () => Navigator.pop(ctx, ImageSource.camera),
                  ),
                  const SizedBox(height: 10),
                  _SourceOptionTile(
                    icon: Icons.photo_library_rounded,
                    title: 'Gallery',
                    subtitle: 'Upload existing front & back images',
                    onTap: () => Navigator.pop(ctx, ImageSource.gallery),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: OpenLabelTheme.bodyGrey.withValues(alpha: 0.85),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    if (!mounted || source == null) return;

    final front = await _picker.pickImage(
      source: source,
      imageQuality: 88,
    );
    if (!mounted || front == null) return;

    final back = await _picker.pickImage(
      source: source,
      imageQuality: 88,
    );
    if (!mounted || back == null) return;

    ref.read(analysisControllerProvider.notifier).analyzeImages(front, back);
    if (!mounted) return;
    context.push('/loading');
  }

  void _onUrlSubmit() {
    final url = _urlController.text.trim();
    if (url.isEmpty) return;
    HapticFeedback.selectionClick();
    ref.read(analysisControllerProvider.notifier).analyzeUrl(url);
    context.push('/loading');
  }

  @override
  Widget build(BuildContext context) {
    final focused = _urlFocus.hasFocus;
    ref.watch(languagePersistenceProvider);
    final lang = ref.watch(languageProvider);

    return Scaffold(
      backgroundColor: OpenLabelTheme.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'OpenLabel',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Scan the truth. Cart-check the spin.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Tooltip(
                      message: TranslationService.t('settings', lang),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color:
                                    OpenLabelTheme.border.withValues(alpha: 0.9),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: lang,
                                items: const [
                                  DropdownMenuItem(
                                    value: 'en',
                                    child: Text('EN'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'hi',
                                    child: Text('हिंदी'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'mr',
                                    child: Text('मराठी'),
                                  ),
                                ],
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.white70,
                                ),
                                dropdownColor:
                                    const Color(0xFF0E0E0E),
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                onChanged: (value) {
                                  if (value == null) return;
                                  HapticFeedback.lightImpact();
                                  ref.read(languageProvider.notifier).state =
                                      value;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => context.push('/profile'),
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        width: 44,
                        height: 44,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: OpenLabelTheme.neonGreen.withValues(alpha: 0.55),
                            width: 1.4,
                          ),
                          color: OpenLabelTheme.surface.withValues(alpha: 0.55),
                          boxShadow: [
                            BoxShadow(
                              color: OpenLabelTheme.neonGreen.withValues(alpha: 0.18),
                              blurRadius: 26,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person_rounded,
                          color: OpenLabelTheme.neonGreen,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              sliver: SliverToBoxAdapter(
                child: ScaleTransition(
                  scale: _bounceScale,
                  child: _ScanPackageCard(
                    onTap: _onScanTap,
                    title: TranslationService.t('scan_package', lang),
                    subtitle:
                        TranslationService.t('scan_package_subtitle', lang),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                child: _CartCopCard(
                  controller: _urlController,
                  focusNode: _urlFocus,
                  focused: focused,
                  onSubmit: _onUrlSubmit,
                  title: TranslationService.t('cart_cop', lang),
                  subtitle: TranslationService.t('cart_cop_subtitle', lang),
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

class _ScanPackageCard extends StatelessWidget {
  const _ScanPackageCard({
    required this.onTap,
    required this.title,
    required this.subtitle,
  });

  final VoidCallback onTap;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        splashColor: OpenLabelTheme.neonGreen.withValues(alpha: 0.12),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: OpenLabelTheme.surface,
            border: Border.all(color: OpenLabelTheme.border),
            boxShadow: [
              BoxShadow(
                color: OpenLabelTheme.neonGreen.withValues(alpha: 0.08),
                blurRadius: 40,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: OpenLabelTheme.neonGreen.withValues(alpha: 0.12),
                    border: Border.all(
                      color: OpenLabelTheme.neonGreen.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Text(
                    'PHYSICAL',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: OpenLabelTheme.neonGreen,
                          fontSize: 11,
                          letterSpacing: 1.4,
                        ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.6,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.document_scanner_rounded,
                      color: OpenLabelTheme.neonGreen,
                      size: 26,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Two quick photos',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CartCopCard extends StatelessWidget {
  const _CartCopCard({
    required this.controller,
    required this.focusNode,
    required this.focused,
    required this.onSubmit,
    required this.title,
    required this.subtitle,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool focused;
  final VoidCallback onSubmit;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: OpenLabelTheme.surface,
        border: Border.all(color: OpenLabelTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              boxShadow: focused
                  ? [
                      BoxShadow(
                        color: OpenLabelTheme.neonGreen.withValues(alpha: 0.35),
                        blurRadius: 22,
                        spreadRadius: 0,
                      ),
                    ]
                  : null,
            ),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                  ),
              cursorColor: OpenLabelTheme.neonGreen,
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.go,
              onSubmitted: (_) => onSubmit(),
              decoration: InputDecoration(
                hintText: 'https://…',
                prefixIcon: Icon(
                  Icons.link_rounded,
                  color: focused
                      ? OpenLabelTheme.neonGreen
                      : OpenLabelTheme.bodyGrey.withValues(alpha: 0.6),
                ),
                filled: true,
                fillColor: const Color(0xFF121212),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                  borderSide: BorderSide(
                    color: focused
                        ? OpenLabelTheme.neonGreen
                        : OpenLabelTheme.border,
                    width: focused ? 1.5 : 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                  borderSide: const BorderSide(color: OpenLabelTheme.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                  borderSide: const BorderSide(
                    color: OpenLabelTheme.neonGreen,
                    width: 1.5,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onSubmit,
              style: TextButton.styleFrom(
                foregroundColor: OpenLabelTheme.neonGreen,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              child: const Text('Run Cart-Cop'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SourceOptionTile extends StatelessWidget {
  const _SourceOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: OpenLabelTheme.border),
            color: const Color(0xFF121212),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: OpenLabelTheme.neonGreen, size: 28),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white.withValues(alpha: 0.45),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
