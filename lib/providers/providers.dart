import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/models/models.dart';
import '../data/product_data.dart';

// ─── Products Provider ────────────────────────────────────────────────────────
final selectedCategoryProvider = StateProvider<String>((ref) => 'All');

final filteredProductsProvider = Provider<List<Product>>((ref) {
  final cat = ref.watch(selectedCategoryProvider);
  if (cat == 'All') return allProducts;
  return allProducts.where((p) => p.category == cat).toList();
});

// ─── Cart Provider ────────────────────────────────────────────────────────────
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void add(Product product) {
    final idx = state.indexWhere((i) => i.product.id == product.id);
    if (idx >= 0) {
      final updated = [...state];
      updated[idx] = CartItem(product: updated[idx].product, quantity: updated[idx].quantity + 1);
      state = updated;
    } else {
      state = [...state, CartItem(product: product)];
    }
  }

  void increment(String productId) {
    state = state.map((i) {
      if (i.product.id == productId) return CartItem(product: i.product, quantity: i.quantity + 1);
      return i;
    }).toList();
  }

  void decrement(String productId) {
    final item = state.firstWhere((i) => i.product.id == productId, orElse: () => CartItem(product: allProducts.first));
    if (item.quantity <= 1) {
      state = state.where((i) => i.product.id != productId).toList();
    } else {
      state = state.map((i) {
        if (i.product.id == productId) return CartItem(product: i.product, quantity: i.quantity - 1);
        return i;
      }).toList();
    }
  }

  void remove(String productId) {
    state = state.where((i) => i.product.id != productId).toList();
  }

  void clear() => state = [];

  int quantityOf(String productId) {
    final idx = state.indexWhere((i) => i.product.id == productId);
    return idx >= 0 ? state[idx].quantity : 0;
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);

final cartItemCountProvider = Provider<int>((ref) {
  return ref.watch(cartProvider).fold(0, (sum, i) => sum + i.quantity);
});

final cartSubtotalProvider = Provider<double>((ref) {
  return ref.watch(cartProvider).fold(0.0, (sum, i) => sum + i.subtotal);
});
