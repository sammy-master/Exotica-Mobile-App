import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/ex_colors.dart';
import '../../core/theme/ex_typography.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });

    return Scaffold(
      backgroundColor: ExColors.void_,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'EXOTICA',
              style: ExTypography.caslon(
                size: 48,
                weight: FontWeight.w700,
                color: ExColors.gold,
                letterSpacing: 0.12 * 48,
              ),
            )
                .animate()
                .fadeIn(duration: 800.ms)
                .slideY(begin: 0.1, duration: 800.ms, curve: Curves.easeOut),
            const SizedBox(height: 16),
            Container(
              width: 40,
              height: 1,
              decoration: const BoxDecoration(
                gradient: ExColors.goldGradient,
              ),
            )
                .animate(delay: 400.ms)
                .fadeIn(duration: 600.ms)
                .scaleX(begin: 0, duration: 600.ms, curve: Curves.easeOut),
          ],
        ),
      ),
    );
  }
}
