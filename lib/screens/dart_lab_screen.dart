import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../models/dart_test_model.dart';
import '../theme/theme.dart';

class DartLabScreen extends StatelessWidget {
  const DartLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OpenLabelTheme.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DART Lab',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              'FSSAI At-Home Tests',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: OpenLabelTheme.bodyGrey),
            ),
          ],
        ),
        backgroundColor: OpenLabelTheme.surface,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Text(
                'Physical verification for the modern kitchen.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final test = mockDartTests[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _DartTestCard(test: test),
                );
              }, childCount: mockDartTests.length),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
    );
  }
}

class _DartTestCard extends StatelessWidget {
  final DartTest test;

  const _DartTestCard({required this.test});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        _showTestModal(context, test);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: OpenLabelTheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: OpenLabelTheme.neonGreen.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.science_outlined,
                color: OpenLabelTheme.neonGreen,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    test.foodItem,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        size: 14,
                        color: OpenLabelTheme.warningYellow,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Detects: ${test.adulterant}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: OpenLabelTheme.warningYellow,
                                fontWeight: FontWeight.w500,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: OpenLabelTheme.bodyGrey),
          ],
        ),
      ),
    );
  }
}

void _showTestModal(BuildContext context, DartTest test) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => _DartTestModal(test: test),
  );
}

class _DartTestModal extends StatelessWidget {
  final DartTest test;

  const _DartTestModal({required this.test});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 0.9;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: OpenLabelTheme.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 48,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: OpenLabelTheme.neonGreen.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.science_outlined,
                        color: OpenLabelTheme.neonGreen,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            test.foodItem,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                          ),
                          Text(
                            'Testing for: ${test.adulterant}',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(color: OpenLabelTheme.warningYellow),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _SectionTitle(
                  title: 'Materials Needed',
                  icon: Icons.inventory_2_outlined,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: OpenLabelTheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Text(
                    test.materialsNeeded,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                _SectionTitle(title: 'Steps', icon: Icons.list_alt_rounded),
                const SizedBox(height: 16),
                ...test.steps.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: OpenLabelTheme.surface,
                            shape: BoxShape.circle,
                            border: Border.all(color: OpenLabelTheme.neonGreen),
                          ),
                          child: Text(
                            '${entry.key + 1}',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
                                  color: OpenLabelTheme.neonGreen,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: Colors.white, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 16),
                _SectionTitle(title: 'Results', icon: Icons.analytics_outlined),
                const SizedBox(height: 16),
                _ResultBlock(
                  title: 'Adulteration Found',
                  description: test.resultPositive,
                  isPositive: true,
                ),
                const SizedBox(height: 12),
                _ResultBlock(
                  title: 'Pure / Safe',
                  description: test.resultNegative,
                  isPositive: false,
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionTitle({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: OpenLabelTheme.bodyGrey, size: 20),
        const SizedBox(width: 8),
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: OpenLabelTheme.bodyGrey,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _ResultBlock extends StatelessWidget {
  final String title;
  final String description;
  final bool isPositive;

  const _ResultBlock({
    required this.title,
    required this.description,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    final color = isPositive
        ? OpenLabelTheme.electricRed
        : OpenLabelTheme.neonGreen;
    final icon = isPositive
        ? Icons.warning_rounded
        : Icons.check_circle_rounded;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
