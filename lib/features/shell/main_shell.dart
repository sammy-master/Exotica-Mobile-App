import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/ex_colors.dart';
import '../../core/theme/ex_typography.dart';
import '../../providers/providers.dart';
import '../../core/widgets/cart_bottom_sheet.dart';
import '../home/home_screen.dart';
import '../categories/categories_screen.dart';
import '../profile/profile_screen.dart';

final _navIndexProvider = StateProvider<int>((ref) => 0);

class MainShell extends ConsumerWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idx = ref.watch(_navIndexProvider);
    final cartCount = ref.watch(cartItemCountProvider);

    final pages = const [HomeScreen(), CategoriesScreen(), ProfileScreen()];

    return Scaffold(
      backgroundColor: ExColors.void_,
      body: IndexedStack(index: idx, children: pages),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: ExColors.surfaceGlass,
          border: Border(top: BorderSide(color: ExColors.divider)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(icon: Icons.home_outlined, label: 'Home', index: 0, current: idx),
                _NavItem(icon: Icons.grid_view_rounded, label: 'Categories', index: 1, current: idx),
                // Cart (opens bottom sheet)
                GestureDetector(
                  onTap: () => showCartBottomSheet(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: ExColors.textMuted,
                            size: 24,
                          ),
                          if (cartCount > 0)
                            Positioned(
                              top: -4,
                              right: -6,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                  gradient: ExColors.goldGradient,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '$cartCount',
                                    style: ExTypography.inter(size: 9, weight: FontWeight.w700, color: ExColors.void_),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text('Orders', style: ExTypography.navLabel),
                    ],
                  ),
                ),
                _NavItem(icon: Icons.person_outline_rounded, label: 'Profile', index: 2, current: idx),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends ConsumerWidget {
  final IconData icon;
  final String label;
  final int index;
  final int current;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.current,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = index == current;

    return GestureDetector(
      onTap: () => ref.read(_navIndexProvider.notifier).state = index,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? ExColors.gold : ExColors.textMuted, size: 24),
            const SizedBox(height: 3),
            Text(
              label,
              style: ExTypography.navLabel.copyWith(
                color: isActive ? ExColors.gold : ExColors.textMuted,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
