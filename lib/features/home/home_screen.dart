import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/theme/ex_colors.dart';
import '../../core/theme/ex_typography.dart';
import '../../core/widgets/widgets.dart';
import '../../core/models/models.dart';
import '../../data/product_data.dart';
import '../../providers/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _bannerController = PageController();
  int _bannerIdx = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), _autoScroll);
  }

  void _autoScroll() {
    if (!mounted) return;
    final next = (_bannerIdx + 1) % heroBanners.length;
    _bannerController.animateToPage(
      next,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
    Future.delayed(const Duration(seconds: 4), _autoScroll);
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bestsellers = allProducts.where((p) => p.isBestseller).toList();
    final newArrivals = allProducts.where((p) => p.isNew).toList();

    return Scaffold(
      backgroundColor: ExColors.void_,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // ─── App Bar ─────────────────────────────────────────────────
              SliverAppBar(
                backgroundColor: ExColors.void_,
                floating: true,
                snap: true,
                elevation: 0,
                scrolledUnderElevation: 0,
                title: Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: ExColors.gold, size: 18),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Exotica PCMC', style: ExTypography.brandName.copyWith(fontSize: 18)),
                        Text('Pimpri-Chinchwad, Pune',
                            style: ExTypography.bodySm.copyWith(fontSize: 11, color: ExColors.textMuted)),
                      ],
                    ),
                  ],
                ),
                centerTitle: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search_rounded, color: ExColors.textPrimary),
                    onPressed: () {},
                  ),
                ],
              ),

              // ─── Search Bar ───────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                  child: TextField(
                    style: ExTypography.bodyLg.copyWith(color: ExColors.textPrimary),
                    decoration: const InputDecoration(
                      hintText: 'Search for imported treats...',
                      prefixIcon: Icon(Icons.search, color: ExColors.textMuted, size: 20),
                    ),
                  ),
                ),
              ),

              // ─── Hero Banner Carousel ─────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 220,
                          child: PageView.builder(
                            controller: _bannerController,
                            onPageChanged: (i) => setState(() => _bannerIdx = i),
                            itemCount: heroBanners.length,
                            itemBuilder: (_, i) => _BannerSlide(banner: heroBanners[i]),
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: AnimatedSmoothIndicator(
                              activeIndex: _bannerIdx,
                              count: heroBanners.length,
                              effect: const WormEffect(
                                dotWidth: 6,
                                dotHeight: 6,
                                activeDotColor: ExColors.gold,
                                dotColor: Colors.white24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 28)),

              // ─── Category Pills ───────────────────────────────────────────
              const SliverToBoxAdapter(child: _CategoryPills()),

              const SliverToBoxAdapter(child: SizedBox(height: 28)),

              // ─── New Arrivals ─────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionHeader(title: 'New Arrivals', onSeeAll: () {}),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 230,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: newArrivals.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (_, i) => SizedBox(
                          width: 150,
                          child: ProductCard(product: newArrivals[i]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 28)),

              // ─── Best Sellers ─────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionHeader(title: 'Best Sellers', onSeeAll: () {}),
                    const SizedBox(height: 12),
                    ...bestsellers.map((p) => _BestsellerRow(product: p, index: bestsellers.indexOf(p))),
                  ],
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          const CartFab(),
        ],
      ),
    );
  }
}

// ─── Hero Banner Slide ────────────────────────────────────────────────────────
class _BannerSlide extends StatelessWidget {
  final Map<String, String> banner;
  const _BannerSlide({required this.banner});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          banner['image']!,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(color: ExColors.surface),
        ),
        // Dark gradient overlay
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [Colors.transparent, Color(0xE6050505)],
            ),
          ),
        ),
        // Content
        Positioned(
          left: 16,
          bottom: 28,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ExTag(label: banner['tag']!),
              const SizedBox(height: 8),
              Text(banner['title']!, style: ExTypography.displayLg.copyWith(color: ExColors.goldLight)),
              const SizedBox(height: 4),
              Text(banner['subtitle']!, style: ExTypography.bodySm.copyWith(color: ExColors.textSecondary)),
              const SizedBox(height: 12),
              GoldButton(label: 'Explore Collection', height: 38, width: 170),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Category Pills ───────────────────────────────────────────────────────────
class _CategoryPills extends ConsumerWidget {
  const _CategoryPills();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const cats = ['All', 'Chocolates', 'Drinks', 'Candy', 'Biscuits', 'Other'];
    final selected = ref.watch(selectedCategoryProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: cats.map((cat) {
          final isActive = selected == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => ref.read(selectedCategoryProvider.notifier).state = cat,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: isActive ? ExColors.goldGradient : null,
                  color: isActive ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: isActive ? ExColors.gold : ExColors.border,
                    width: isActive ? 0 : 1,
                  ),
                ),
                child: Text(
                  cat,
                  style: ExTypography.inter(
                    size: 13,
                    weight: isActive ? FontWeight.w700 : FontWeight.w400,
                    color: isActive ? ExColors.void_ : ExColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─── Section Header ───────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const _SectionHeader({required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: ExTypography.headlineMd),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: Text('See All', style: ExTypography.inter(size: 13, color: ExColors.gold, weight: FontWeight.w500)),
            ),
        ],
      ),
    );
  }
}

// ─── Bestseller Row ───────────────────────────────────────────────────────────
class _BestsellerRow extends ConsumerWidget {
  final Product product;
  final int index;
  const _BestsellerRow({required this.product, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qty = ref.watch(cartProvider.notifier).quantityOf(product.id);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ProductDetailPage(product: product)),
      ),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ExColors.surfaceCard,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ExColors.border),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: SizedBox(
                width: 56,
                height: 56,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: ExColors.surface),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: ExTypography.caslon(size: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(product.country, style: ExTypography.bodySm.copyWith(fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('₹${product.price.toInt()}', style: ExTypography.price.copyWith(fontSize: 16)),
                const SizedBox(height: 4),
                qty == 0
                    ? GestureDetector(
                        onTap: () => ref.read(cartProvider.notifier).add(product),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            gradient: ExColors.goldGradient,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, color: ExColors.void_, size: 18),
                        ),
                      )
                    : Text('×$qty', style: ExTypography.tag.copyWith(color: ExColors.gold)),
              ],
            ),
          ],
        ),
      ),
    ).animate(delay: Duration(milliseconds: index * 60)).fadeIn(duration: const Duration(milliseconds: 400));
  }
}
