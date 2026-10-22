import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/ex_colors.dart';
import '../../core/theme/ex_typography.dart';
import '../../core/models/ex_const.dart';
import '../../core/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _launch(String uri) async {
    final url = Uri.parse(uri);
    if (await canLaunchUrl(url)) await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ExColors.void_,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            backgroundColor: ExColors.void_,
            floating: true,
            elevation: 0,
            centerTitle: true,
            title: Text('EXOTICA', style: ExTypography.brandName),
            actions: [
              IconButton(icon: const Icon(Icons.search_rounded, color: ExColors.textPrimary), onPressed: () {}),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ─── Help Center Header ─────────────────────────────────
                  Text('Help Center', style: ExTypography.displayLg.copyWith(color: ExColors.goldText, fontSize: 40)),
                  const SizedBox(height: 8),
                  Text(
                    'How can we assist you with your exclusive experience?',
                    style: ExTypography.bodyLg.copyWith(color: ExColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // ─── Store Info Card ────────────────────────────────────
                  GlassCard(
                    goldBorder: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('STORE INFORMATION', style: ExTypography.labelCaps),
                        const SizedBox(height: 12),
                        _InfoRow(icon: Icons.location_on_outlined, text: ExConst.address),
                        const SizedBox(height: 10),
                        _InfoRow(icon: Icons.access_time_rounded, text: ExConst.timings),
                        const SizedBox(height: 10),
                        _InfoRow(icon: Icons.phone_outlined, text: '${ExConst.phone1} / ${ExConst.phone2}'),
                        const SizedBox(height: 10),
                        _InfoRow(icon: Icons.verified_outlined, text: '${ExConst.fssai}\n${ExConst.gst}'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ─── FAQ Section ────────────────────────────────────────
                  Text('Frequently Asked Questions', style: ExTypography.headlineMd),
                  const SizedBox(height: 16),
                  const _FaqItem(
                    question: 'Where is my order?',
                    answer:
                        'Our team will call you to confirm your order and coordinate delivery. Orders within PCMC are typically delivered within 1–3 hours.',
                  ),
                  const _FaqItem(
                    question: 'How do I place an order?',
                    answer:
                        'You can add items to your cart and proceed to checkout, or directly WhatsApp us at +91 92969 09095 and we\'ll assist you.',
                  ),
                  const _FaqItem(
                    question: 'What is the return policy for imported goods?',
                    answer:
                        'We accept returns within 48 hours of delivery for damaged or incorrect items. Please contact us via WhatsApp with your order details.',
                  ),
                  const _FaqItem(
                    question: 'Are all your products authentic?',
                    answer:
                        'Yes! All our products are 100% imported and authentic. We are FSSAI registered (Reg. No. 21526038001776) and GST compliant.',
                  ),

                  const SizedBox(height: 32),

                  // ─── Contact Buttons ────────────────────────────────────
                  Text('Still need help?', style: ExTypography.headlineMd.copyWith(fontSize: 20)),
                  const SizedBox(height: 16),
                  GoldButton(
                    label: 'WhatsApp Us',
                    icon: Icons.chat_outlined,
                    outlined: true,
                    onTap: () => _launch(ExConst.whatsappUri),
                  ),
                  const SizedBox(height: 12),
                  GoldButton(
                    label: 'Call Store',
                    icon: Icons.phone_outlined,
                    onTap: () => _launch(ExConst.phoneUri),
                  ),
                  const SizedBox(height: 20),

                  // ─── Instagram ──────────────────────────────────────────
                  GestureDetector(
                    onTap: () => _launch(ExConst.instagram),
                    child: GlassCard(
                      child: Row(
                        children: [
                          const Icon(Icons.camera_alt_outlined, color: ExColors.gold),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Follow us on Instagram', style: ExTypography.inter(size: 13, weight: FontWeight.w600, color: ExColors.textPrimary)),
                              Text(ExConst.instagramHandle, style: ExTypography.bodySm.copyWith(color: ExColors.gold)),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_rounded, color: ExColors.textMuted, size: 14),
                        ],
                      ),
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

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: ExColors.gold, size: 16),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: ExTypography.bodySm.copyWith(color: ExColors.textSecondary))),
      ],
    );
  }
}

class _FaqItem extends StatefulWidget {
  final String question, answer;
  const _FaqItem({required this.question, required this.answer});

  @override
  State<_FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<_FaqItem> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _open = !_open),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: ExColors.surfaceCard,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: _open ? ExColors.borderGold : ExColors.border),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(widget.question, style: ExTypography.inter(size: 14, weight: FontWeight.w500, color: ExColors.textPrimary))),
                  Icon(
                    _open ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    color: ExColors.gold,
                    size: 20,
                  ),
                ],
              ),
            ),
            if (_open) ...[
              const Divider(color: ExColors.divider, height: 1),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Text(widget.answer, style: ExTypography.bodySm.copyWith(color: ExColors.textSecondary)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
