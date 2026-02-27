import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CoinIcon extends StatelessWidget {
  const CoinIcon({
    this.size = 24,
    super.key,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.coinGold,
      ),
      child: Center(
        child: Text(
          'S',
          style: TextStyle(
            fontSize: size * 0.55,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
