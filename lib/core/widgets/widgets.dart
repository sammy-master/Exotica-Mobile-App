import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/ex_colors.dart';
import '../theme/ex_typography.dart';
import '../models/models.dart';
import '../../providers/providers.dart';
import 'cart_bottom_sheet.dart';

// ─── Gold Primary Button ──────────────────────────────────────────────────────
class GoldButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final double height;
  final double? width;
  final bool outlined;

  const GoldButton({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.height = 52,
    this.width,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          gradient: outlined ? null : ExColors.goldGradient,
          color: outlined ? Colors.transparent : null,
          borderRadius: BorderRadius.circular(4),
          border: outlined ? Border.all(color: ExColors.gold, width: 1) : null,
          boxShadow: outlined ? null : ExColors.goldGlow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: outlined ? ExColors.gold : ExColors.void_),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: ExTypography.buttonLabel.copyWith(
                color: outlined ? ExColors.gold : ExColors.void_,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Glass Card ───────────────────────────────────────────────────────────────
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final bool goldBorder;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 12,
    this.goldBorder = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ExColors.surfaceGlass,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: goldBorder ? ExColors.borderGold : ExColors.border,
            width: goldBorder ? 1 : 0.5,
          ),
          boxShadow: ExColors.cardShadow,
        ),
        child: child,
      ),
    );
  }
}

// ─── Tag Chip ─────────────────────────────────────────────────────────────────
class ExTag extends StatelessWidget {
  final String label;

  const ExTag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: ExColors.void_.withValues(alpha: 0.6),
        border: Border.all(color: ExColors.gold, width: 0.5),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(label.toUpperCase(), style: ExTypography.tag),
    );
  }
}

// ─── Product Card ─────────────────────────────────────────────────────────────
class ProductCard extends ConsumerWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qty = ref.watch(cartProvider.notifier).quantityOf(product.id);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ProductDetailPage(product: product)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ExColors.surfaceGlass,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ExColors.border, width: 0.5),
          boxShadow: ExColors.cardShadow,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image — expands to fill available space
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: ExColors.surface,
                      child: const Icon(Icons.image_outlined, color: ExColors.textMuted, size: 32),
                    ),
                    loadingBuilder: (_, child, progress) {
                      if (progress == null) return child;
                      return Container(color: ExColors.surface);
                    },
                  ),
                  if (product.tag != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: ExTag(label: product.tag!),
                    ),
                ],
              ),
            ),
            // Info — fixed content, clamps to min size
            Container(
              color: ExColors.surfaceGlass,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.name,
                    style: ExTypography.caslon(size: 12, height: 1.3),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product.country,
                    style: ExTypography.bodySm.copyWith(fontSize: 10),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          '₹${product.price.toInt()}',
                          style: ExTypography.price.copyWith(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      qty == 0
                          ? _AddButton(product: product)
                          : _QtyControl(product: product, qty: qty),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends ConsumerWidget {
  final Product product;
  const _AddButton({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref.read(cartProvider.notifier).add(product),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: ExColors.gold, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text('+ ADD', style: ExTypography.tag.copyWith(fontSize: 10)),
      ),
    );
  }
}

class _QtyControl extends ConsumerWidget {
  final Product product;
  final int qty;
  const _QtyControl({required this.product, required this.qty});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => ref.read(cartProvider.notifier).decrement(product.id),
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: ExColors.surfaceCard,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: ExColors.border),
            ),
            child: const Icon(Icons.remove, size: 12, color: ExColors.gold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            '$qty',
            style: ExTypography.inter(size: 12, weight: FontWeight.w600, color: ExColors.textPrimary),
          ),
        ),
        GestureDetector(
          onTap: () => ref.read(cartProvider.notifier).increment(product.id),
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              gradient: ExColors.goldGradient,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.add, size: 12, color: ExColors.void_),
          ),
        ),
      ],
    );
  }
}

// ─── Cart FAB ─────────────────────────────────────────────────────────────────
class CartFab extends ConsumerWidget {
  const CartFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(cartItemCountProvider);
    final subtotal = ref.watch(cartSubtotalProvider);

    if (count == 0) return const SizedBox.shrink();

    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: GestureDetector(
        onTap: () => showCartBottomSheet(context),
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            gradient: ExColors.goldGradient,
            borderRadius: BorderRadius.circular(8),
            boxShadow: ExColors.goldGlow,
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: ExColors.void_,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$count',
                    style: ExTypography.inter(size: 11, weight: FontWeight.w700, color: ExColors.gold),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text('Your Collection', style: ExTypography.inter(size: 14, weight: FontWeight.w700, color: ExColors.void_)),
              const Spacer(),
              Text('₹${subtotal.toInt()}', style: ExTypography.inter(size: 15, weight: FontWeight.w700, color: ExColors.void_)),
            ],
          ),
        ),
      ).animate().slideY(begin: 0.5, duration: const Duration(milliseconds: 300), curve: Curves.easeOutCubic),
    );
  }
}

// ─── Product Detail Page ──────────────────────────────────────────────────────
class ProductDetailPage extends ConsumerWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qty = ref.watch(cartProvider.notifier).quantityOf(product.id);

    return Scaffold(
      backgroundColor: ExColors.void_,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 320,
                pinned: true,
                backgroundColor: ExColors.void_,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: ExColors.gold),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text('Exotica', style: ExTypography.brandName.copyWith(fontSize: 18)),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: ExColors.surface),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        children: [
                          ExTag(label: product.country),
                          if (product.tag != null) ExTag(label: product.tag!),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(product.name, style: ExTypography.displayLg),
                      const SizedBox(height: 4),
                      Text(
                        product.category,
                        style: ExTypography.bodySm.copyWith(
                          color: ExColors.gold,
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('TASTING NOTES', style: ExTypography.labelCaps),
                      const SizedBox(height: 8),
                      Text(product.description, style: ExTypography.bodyLg),
                      const SizedBox(height: 28),
                      const Divider(color: ExColors.divider),
                      const SizedBox(height: 16),
                      Text('SPECIFICATIONS', style: ExTypography.labelCaps),
                      const SizedBox(height: 12),
                      _SpecRow(label: 'Country of Origin', value: product.country),
                      _SpecRow(label: 'Category', value: product.category),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Bottom bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              decoration: const BoxDecoration(
                color: ExColors.surfaceGlass,
                border: Border(top: BorderSide(color: ExColors.divider)),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('TOTAL', style: ExTypography.labelCaps),
                      Text('₹${product.price.toInt()}', style: ExTypography.priceLg),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: qty == 0
                        ? GoldButton(
                            label: '+ ADD TO COLLECTION',
                            height: 52,
                            onTap: () => ref.read(cartProvider.notifier).add(product),
                          )
                        : Row(
                            children: [
                              _LgQtyBtn(
                                icon: Icons.remove,
                                onTap: () => ref.read(cartProvider.notifier).decrement(product.id),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text('$qty', style: ExTypography.titleLg),
                                ),
                              ),
                              _LgQtyBtn(
                                icon: Icons.add,
                                gold: true,
                                onTap: () => ref.read(cartProvider.notifier).increment(product.id),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecRow extends StatelessWidget {
  final String label, value;
  const _SpecRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: ExTypography.bodySm),
          Text(value, style: ExTypography.inter(size: 14, weight: FontWeight.w600, color: ExColors.textPrimary)),
        ],
      ),
    );
  }
}

class _LgQtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool gold;
  const _LgQtyBtn({required this.icon, required this.onTap, this.gold = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          gradient: gold ? ExColors.goldGradient : null,
          color: gold ? null : ExColors.surfaceCard,
          borderRadius: BorderRadius.circular(8),
          border: gold ? null : Border.all(color: ExColors.border),
        ),
        child: Icon(icon, color: gold ? ExColors.void_ : ExColors.textPrimary, size: 20),
      ),
    );
  }
}
