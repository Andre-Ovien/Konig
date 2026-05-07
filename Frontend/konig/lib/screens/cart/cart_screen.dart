import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konig/controllers/navigation_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  final List<Map<String, dynamic>> items = const [
    {
      'name': 'Fresh Tomatoes',
      'meta': '2 baskets',
      'price': 50.00,
      'quantity': 1,
      'image': 'assets/images/tomato.jpg',
    },
    {
      'name': 'Sweet Pineapple',
      'meta': '3 pieces',
      'price': 48.00,
      'quantity': 1,
      'image': 'assets/images/pineapple.jpg',
    },
    {
      'name': 'Soya Beans',
      'meta': '5 kg',
      'price': 40.00,
      'quantity': 1,
      'image': 'assets/images/soya_beans.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final NavigationController nav = Get.find<NavigationController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    const orderAmount = 138.00;
    const tax = 10.00;
    const total = orderAmount + tax;

    return Scaffold(
      extendBody: true,
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFEFF2F6),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 18),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.black.withOpacity(0.28)
                          : Colors.white.withOpacity(0.62),
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withOpacity(0.08)
                            : Colors.white.withOpacity(0.68),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => nav.changeIndex(0),
                                child: const Icon(
                                  Icons.chevron_left_rounded,
                                  size: 28,
                                ),
                              ),
                              const Expanded(
                                child: Center(
                                  child: Text(
                                    'Cart',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 28),
                            ],
                          ),
                        ),

                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
                            itemCount: items.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              return _CartItemTile(item: items[index]);
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 4, 18, 18),
                          child: Column(
                            children: [
                              _PromoCodeField(isDark: isDark),
                              const SizedBox(height: 22),
                              const _SummaryRow(
                                label: 'Order Amount',
                                value: '\$138.00',
                              ),
                              const SizedBox(height: 14),
                              Divider(
                                color: isDark
                                    ? Colors.white.withOpacity(0.10)
                                    : Colors.black.withOpacity(0.08),
                                height: 1,
                              ),
                              const SizedBox(height: 14),
                              const _SummaryRow(
                                label: 'Tax',
                                value: '\$10.00',
                              ),
                              const SizedBox(height: 14),
                              Divider(
                                color: isDark
                                    ? Colors.white.withOpacity(0.10)
                                    : Colors.black.withOpacity(0.08),
                                height: 1,
                              ),
                              const SizedBox(height: 14),
                              const _SummaryRow(
                                label: 'Total Payment',
                                value: '\$148.00',
                                trailing: '(3 items)',
                                isBold: true,
                              ),
                              const SizedBox(height: 34),
                              SizedBox(
                                width: double.infinity,
                                height: 54,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF31B653),
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  child: const Text(
                                    'Proceed To Checkout',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  final Map<String, dynamic> item;

  const _CartItemTile({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 72,
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[850] : const Color(0xFFECEFF3),
              borderRadius: BorderRadius.circular(14),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              item['image'] as String,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.1,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['meta'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.1,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.grey[400] : Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '\$${(item['price'] as double).toStringAsFixed(2)}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.1,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          const _QuantityButton(icon: Icons.remove_rounded, filled: false),
          const SizedBox(width: 7),
          Text(
            '${item['quantity']}'.padLeft(2, '0'),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 7),
          const _QuantityButton(icon: Icons.add_rounded, filled: true),
        ],
      ),
    );
  }
}


class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final bool filled;

  const _QuantityButton({
    required this.icon,
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF31B653);
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: filled ? green : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: filled ? green : const Color(0xFFBBC3CC),
        ),
      ),
      child: Icon(
        icon,
        size: 15,
        color: filled ? Colors.white : const Color(0xFF88919C),
      ),
    );
  }
}

class _PromoCodeField extends StatelessWidget {
  final bool isDark;

  const _PromoCodeField({
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: isDark ? Colors.black.withOpacity(0.20) : Colors.white.withOpacity(0.72),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.08) : Colors.white.withOpacity(0.62),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Promo Code',
                hintStyle: TextStyle(
                  color: isDark ? Colors.grey[500] : Colors.grey[400],
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: SizedBox(
              height: 36,
              width: 72,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF131C24),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final String? trailing;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.trailing,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 13 : 12,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w700,
          ),
        ),
        const Spacer(),
        if (trailing != null) ...[
          Text(
            trailing!,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
        ],
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 15 : 13,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
