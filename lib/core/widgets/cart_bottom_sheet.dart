import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/ex_colors.dart';
import '../theme/ex_typography.dart';
import '../models/models.dart';
import '../../providers/providers.dart';
import '../models/ex_const.dart';

void showCartBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const CartBottomSheet(),
  );
}

class CartBottomSheet extends ConsumerWidget {
  const CartBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartProvider);
    final subtotal = ref.watch(cartSubtotalProvider);
    final delivery = subtotal >= ExConst.freeDeliveryAbove ? 0.0 : ExConst.deliveryFee;
    final total = subtotal + delivery;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.88,
      ),
      decoration: BoxDecoration(
        color: ExColors.surfaceModal,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border.all(color: ExColors.borderGold, width: 0.5),
      ),
      child: Column(
        children: [
          // Handle
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 4),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: ExColors.borderGold,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your Collection', style: ExTypography.headlineMd.copyWith(color: ExColors.goldLight)),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: ExColors.surfaceCard,
                      shape: BoxShape.circle,
                      border: Border.all(color: ExColors.border),
                    ),
                    child: const Icon(Icons.close, color: ExColors.textMuted, size: 16),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: ExColors.divider, height: 1),

          if (items.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.shopping_bag_outlined, color: ExColors.textMuted, size: 48),
                    const SizedBox(height: 12),
                    Text('Your collection is empty', style: ExTypography.bodySm),
                  ],
                ),
              ),
            )
          else ...[
            // Items list
            Flexible(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, i) => _CartItemTile(item: items[i]),
              ),
            ),
            // Summary
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: ExColors.divider)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TRANSACTION DETAILS', style: ExTypography.labelCaps.copyWith(letterSpacing: 1.5)),
                  const SizedBox(height: 12),
                  _SummaryRow(label: 'Item Total', value: '₹${subtotal.toInt()}'),
                  const SizedBox(height: 8),
                  _SummaryRow(
                    label: 'Delivery Fee',
                    value: delivery == 0 ? 'FREE' : '₹${delivery.toInt()}',
                    valueColor: delivery == 0 ? ExColors.gold : null,
                  ),
                  const SizedBox(height: 8),
                  _SummaryRow(label: 'Concierge Service', value: 'Complimentary', valueColor: ExColors.gold),
                  const SizedBox(height: 12),
                  const Divider(color: ExColors.divider, height: 1),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Grand Total', style: ExTypography.titleLg),
                      Text('₹${total.toInt()}', style: ExTypography.priceLg),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _CheckoutButton(total: total),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CartItemTile extends ConsumerWidget {
  final CartItem item;
  const _CartItemTile({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(cartProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ExColors.surfaceCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ExColors.border),
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              width: 64,
              height: 64,
              child: Image.network(
                item.product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: ExColors.surface,
                  child: const Icon(Icons.image_outlined, color: ExColors.textMuted),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: ExTypography.caslon(size: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (item.product.tag != null)
                  Text(item.product.tag!, style: ExTypography.tag.copyWith(fontSize: 11, color: ExColors.textMuted)),
                const SizedBox(height: 6),
                Text('₹${item.product.price.toInt()}', style: ExTypography.price.copyWith(fontSize: 16)),
              ],
            ),
          ),
          // Qty Controls
          Row(
            children: [
              _SmQtyBtn(
                icon: Icons.remove,
                onTap: () => notifier.decrement(item.product.id),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${item.quantity}',
                  style: ExTypography.inter(size: 14, weight: FontWeight.w700, color: ExColors.textPrimary),
                ),
              ),
              _SmQtyBtn(
                icon: Icons.add,
                gold: true,
                onTap: () => notifier.increment(item.product.id),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SmQtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool gold;
  const _SmQtyBtn({required this.icon, required this.onTap, this.gold = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          gradient: gold ? ExColors.goldGradient : null,
          color: gold ? null : ExColors.surfaceGlass,
          borderRadius: BorderRadius.circular(6),
          border: gold ? null : Border.all(color: ExColors.border),
        ),
        child: Icon(icon, size: 14, color: gold ? ExColors.void_ : ExColors.textPrimary),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label, value;
  final Color? valueColor;
  const _SummaryRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: ExTypography.bodyLg.copyWith(fontSize: 14, color: ExColors.textSecondary)),
        Text(
          value,
          style: ExTypography.inter(size: 14, weight: FontWeight.w500, color: valueColor ?? ExColors.textPrimary),
        ),
      ],
    );
  }
}

class _CheckoutButton extends ConsumerWidget {
  final double total;
  const _CheckoutButton({required this.total});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(cartProvider.notifier).clear();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '✓ Order placed! We\'ll call you to confirm. Total: ₹${total.toInt()}',
              style: ExTypography.bodySm.copyWith(color: ExColors.textPrimary),
            ),
            backgroundColor: ExColors.surfaceModal,
            duration: const Duration(seconds: 4),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: ExColors.goldGradient,
          borderRadius: BorderRadius.circular(8),
          boxShadow: ExColors.goldGlow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outlined, color: ExColors.void_, size: 18),
            const SizedBox(width: 10),
            Text('Secure Checkout', style: ExTypography.buttonLabel),
          ],
        ),
      ),
    );
  }
}
