import 'dart:ui';

import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int selectedCategory = 0;

  final categories = const [
    {'name': 'Fruits', 'icon': Icons.apple_rounded},
    {'name': 'Vegetables', 'icon': Icons.eco_rounded},
    {'name': 'Grains', 'icon': Icons.grain_rounded},
    {'name': 'Herbs', 'icon': Icons.spa_rounded},
    {'name': 'Tubers', 'icon': Icons.yard_rounded},
  ];

  final products = const [
    {
      'name': 'Fresh Tomatoes',
      'price': 69.00,
      'stock': 15,
      'rating': 4.6,
      'reviews': 201,
      'image': 'assets/images/tomato.jpg',
    },
    {
      'name': 'Sweet Pineapple',
      'price': 145.00,
      'stock': 10,
      'rating': 4.0,
      'reviews': 185,
      'image': 'assets/images/pineapple.jpg',
    },
    {
      'name': 'Irish Potato',
      'price': 105.00,
      'stock': 12,
      'rating': 4.3,
      'reviews': 151,
      'image': 'assets/images/potato.jpg',
    },
    {
      'name': 'Soya Beans',
      'price': 94.00,
      'stock': 4,
      'rating': 4.5,
      'reviews': 207,
      'image': 'assets/images/soya_beans.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F8F1),
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                    child: Row(
                      children: [
                        _GlassIconButton(
                          icon: Icons.arrow_back_rounded,
                          onTap: () {},
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _GlassSearchField(
                            hintText: 'Search fresh produce...',
                          ),
                        ),
                        const SizedBox(width: 10),
                        _GlassMenuButton(
                          label: 'Farm',
                          icon: Icons.storefront_rounded,
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 38,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: const [
                        _FilterChipButton(icon: Icons.tune_rounded, label: 'Filter'),
                        _FilterChipButton(label: 'Rating'),
                        _FilterChipButton(label: 'Price'),
                        _FilterChipButton(label: 'Category'),
                        _FilterChipButton(label: 'Farm'),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 92,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final item = categories[index];
                        final isSelected = selectedCategory == index;

                        return GestureDetector(
                          onTap: () => setState(() => selectedCategory = index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            width: 68,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF31B653)
                                  : isDark
                                      ? Colors.black.withOpacity(0.24)
                                      : Colors.white.withOpacity(0.62),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.white.withOpacity(0.28)
                                    : Colors.white.withOpacity(0.58),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  item['icon'] as IconData,
                                  color: isSelected ? Colors.white : const Color(0xFF31B653),
                                  size: 24,
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  item['name'] as String,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : isDark
                                            ? Colors.grey[300]
                                            : Colors.grey[700],
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _ShopProductCard(
                        product: products[index],
                      ),
                      childCount: products.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.68,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                  ),
                ),
              ],
            ),

            Positioned(
              left: 18,
              right: 18,
              bottom: 18,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      color: const Color(0xFF31B653).withOpacity(0.90),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.white.withOpacity(0.24)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF31B653).withOpacity(0.30),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'View your cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            '3x',
                            style: TextStyle(
                              color: Color(0xFF31B653),
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          '\$256.00',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassSearchField extends StatelessWidget {
  final String hintText;

  const _GlassSearchField({
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            color: isDark ? Colors.black.withOpacity(0.26) : Colors.white.withOpacity(0.68),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.56)),
          ),
          child: TextField(
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 13,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: isDark ? Colors.grey[400] : Colors.grey[500],
                fontSize: 13,
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: isDark ? Colors.grey[400] : Colors.grey[500],
                size: 20,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 13),
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _GlassIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _GlassBox(
        width: 46,
        height: 46,
        child: Icon(icon, size: 22),
      ),
    );
  }
}

class _GlassMenuButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const _GlassMenuButton({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return _GlassBox(
      width: 86,
      height: 46,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF31B653), size: 19),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
        ],
      ),
    );
  }
}

class _FilterChipButton extends StatelessWidget {
  final String label;
  final IconData? icon;

  const _FilterChipButton({
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: _GlassBox(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 15),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (icon == null) ...[
              const SizedBox(width: 3),
              const Icon(Icons.keyboard_arrow_down_rounded, size: 17),
            ],
          ],
        ),
      ),
    );
  }
}

class _GlassBox extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Widget child;

  const _GlassBox({
    this.width,
    this.height,
    this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: isDark ? Colors.black.withOpacity(0.26) : Colors.white.withOpacity(0.68),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.56)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _ShopProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const _ShopProductCard({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.black.withOpacity(0.24) : Colors.white.withOpacity(0.68),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.58)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 118,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[850] : const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        product['image'] as String,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 14,
                    top: 14,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.86),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: Color(0xFFFF3B4E),
                        size: 17,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color:const Color(0xFF31B653),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '\$${(product['price'] as double).toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${product['stock']} Stocks Left',
                      style: const TextStyle(
                        color: Color(0xFFE06A3B),
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Color(0xFFFFC043), size: 15),
                        const SizedBox(width: 3),
                        Text(
                          '${product['rating']} (${product['reviews']})',
                          style: TextStyle(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      product['name'] as String,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87,
                        fontSize: 13,
                        height: 1.15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
