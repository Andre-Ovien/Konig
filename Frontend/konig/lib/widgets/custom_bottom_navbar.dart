import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konig/controllers/navigation_controller.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController nav = Get.find<NavigationController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Obx(
      () => SafeArea(
        minimum: const EdgeInsets.fromLTRB(18, 0, 18, 10),
        child: SizedBox(
          height: 76,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 18,
                      sigmaY: 18,
                    ),
                    child: Container(
                      height: 62,
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.black.withOpacity(0.42)
                            : Colors.white.withOpacity(0.72),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withOpacity(0.10)
                              : Colors.white.withOpacity(0.55),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              isDark ? 0.30 : 0.10,
                            ),
                            blurRadius: 18,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _NavItem(
                            icon: Icons.home_outlined,
                            activeIcon: Icons.home_rounded,
                            label: 'Home',
                            index: 0,
                            currentIndex: nav.currentIndex.value,
                            onTap: () => nav.changeIndex(0),
                          ),
                          _NavItem(
                            icon: Icons.storefront_outlined,
                            activeIcon: Icons.storefront,
                            label: 'Shop',
                            index: 1,
                            currentIndex: nav.currentIndex.value,
                            onTap: () => nav.changeIndex(1),
                          ),
                          const SizedBox(width: 58),
                          _NavItem(
                            icon: Icons.receipt_long_outlined,
                            activeIcon: Icons.receipt_long_rounded,
                            label: 'Orders',
                            index: 3,
                            currentIndex: nav.currentIndex.value,
                            onTap: () => nav.changeIndex(3),
                          ),
                          _NavItem(
                            icon: Icons.person_outline_rounded,
                            activeIcon: Icons.person_rounded,
                            label: 'Profile',
                            index: 4,
                            currentIndex: nav.currentIndex.value,
                            onTap: () => nav.changeIndex(4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: GestureDetector(
                  onTap: () => nav.changeIndex(2),
                  child: Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: const Color(0xFF31B653),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.42),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF31B653).withOpacity(0.32),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Center(
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF4B27),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = currentIndex == index;
    final color = isActive ? const Color(0xFF31B653) : const Color(0xFF8F8F8F);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 54,
        height: 56,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: color,
              size: 22,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
