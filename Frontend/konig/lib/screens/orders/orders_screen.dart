import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konig/controllers/navigation_controller.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int selectedTab = 0;

  final ongoingOrders = const [
    {
      'farm': 'Konig Farm Fresh',
      'items': '3 Items',
      'amount': '\$148.00',
      'address': 'Delivering to G86G+QQ5, Apapa Oworonshoki Expy, Lagos',
      'status': 'Out for delivery',
    },
  ];

  final completedOrders = const [
    {
      'farm': 'Konig Farm Fresh',
      'items': '2 Items',
      'amount': '\$94.00',
      'address': 'Delivered to Andre',
      'status': 'Delivered',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final NavigationController nav = Get.find<NavigationController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final orders = selectedTab == 0 ? ongoingOrders : completedOrders;

    return Scaffold(
      extendBody: true,
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F8F1),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => nav.changeIndex(0),
                      child: const Icon(Icons.arrow_back_rounded, size: 26),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Orders',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF31B653).withOpacity(0.10),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Text(
                        'Clear',
                        style: TextStyle(
                          color: Color(0xFF16722D),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 26),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                    child: Container(
                      height: 68,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.black.withOpacity(0.24)
                            : Colors.black.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.42),
                        ),
                      ),
                      child: Row(
                        children: [
                          _OrderTabButton(
                            label: 'Ongoing',
                            selected: selectedTab == 0,
                            onTap: () => setState(() => selectedTab = 0),
                          ),
                          _OrderTabButton(
                            label: 'Completed',
                            selected: selectedTab == 1,
                            onTap: () => setState(() => selectedTab = 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
              sliver: SliverList.separated(
                itemCount: orders.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return _OrderCard(
                    order: orders[index],
                    completed: selectedTab == 1,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderTabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _OrderTabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF16722D) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : Colors.grey[600],
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Map<String, String> order;
  final bool completed;

  const _OrderCard({
    required this.order,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.black.withOpacity(0.24)
                : Colors.white.withOpacity(0.72),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.08)
                  : Colors.white.withOpacity(0.66),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFF31B653).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      completed
                          ? Icons.check_circle_rounded
                          : Icons.local_shipping_rounded,
                      color: const Color(0xFF16722D),
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order['farm']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${order['items']} • ${order['amount']}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    completed ? 'View' : 'Track',
                    style: const TextStyle(
                      color: Color(0xFF16722D),
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Divider(
                color: isDark
                    ? Colors.white.withOpacity(0.08)
                    : Colors.black.withOpacity(0.06),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    completed
                        ? Icons.done_all_rounded
                        : Icons.delivery_dining_rounded,
                    color: const Color(0xFF16722D),
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      order['address']!,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.45,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.grey[200] : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFF16722D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    completed ? 'Order Again' : 'Track Order',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
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
