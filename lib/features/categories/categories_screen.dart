import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/ex_colors.dart';
import '../../core/theme/ex_typography.dart';
import '../../core/widgets/widgets.dart';
import '../../data/product_data.dart';
import '../../providers/providers.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCat = ref.watch(selectedCategoryProvider);
    final products = ref.watch(filteredProductsProvider);

    return Scaffold(
      backgroundColor: ExColors.void_,
      body: Stack(
        children: [
          Row(
            children: [
              // ─── Left Sidebar Navigation ──────────────────────────────────
              Container(
                width: 80,
                color: ExColors.surface,
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      const SizedBox(height: 56), // align with app bar
                      Expanded(
                        child: ListView(
                          children: categories
                              .where((c) => c != 'All')
                              .map((cat) {
                            final isActive = selectedCat == cat;
                            return GestureDetector(
                              onTap: () => ref.read(selectedCategoryProvider.notifier).state = cat,
                              child: AnimatedContainer(
                                duration: 200.ms,
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      color: isActive ? ExColors.gold : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                  color: isActive ? ExColors.surfaceCard : Colors.transparent,
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      _catIcon(cat),
                                      color: isActive ? ExColors.gold : ExColors.textMuted,
                                      size: 20,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      cat,
                                      style: ExTypography.inter(
                                        size: 10,
                                        weight: isActive ? FontWeight.w700 : FontWeight.w400,
                                        color: isActive ? ExColors.gold : ExColors.textMuted,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ─── Right Product Grid ───────────────────────────────────────
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    // Header
                    SliverAppBar(
                      backgroundColor: ExColors.void_,
                      automaticallyImplyLeading: false,
                      pinned: true,
                      title: Text('EXOTICA PCMC', style: ExTypography.brandName.copyWith(fontSize: 16)),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.search_rounded, color: ExColors.textPrimary),
                          onPressed: () {},
                        ),
                      ],
                    ),

                    // Filter Chips
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _FilterChip(label: 'Sort by Price'),
                              const SizedBox(width: 8),
                              _FilterChip(label: 'Brand'),
                              const SizedBox(width: 8),
                              _FilterChip(label: 'Offers'),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Product Grid
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 100),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.62,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, i) => ProductCard(product: products[i])
                              .animate(delay: Duration(milliseconds: i * 40))
                              .fadeIn(duration: 300.ms),
                          childCount: products.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const CartFab(),
        ],
      ),
    );
  }

  IconData _catIcon(String cat) {
    switch (cat) {
      case 'Chocolates': return Icons.cookie_outlined;
      case 'Drinks': return Icons.local_drink_outlined;
      case 'Candy': return Icons.icecream_outlined;
      case 'Biscuits': return Icons.breakfast_dining_outlined;
      default: return Icons.category_outlined;
    }
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  const _FilterChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: ExColors.border),
        borderRadius: BorderRadius.circular(100),
        color: ExColors.surfaceGlass,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label.startsWith('Sort'))
            const Padding(
              padding: EdgeInsets.only(right: 4),
              child: Icon(Icons.sort_rounded, size: 13, color: ExColors.textMuted),
            ),
          Text(label, style: ExTypography.bodySm.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}
