import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konig/controllers/theme_controller.dart';
import 'package:konig/models/product.dart';
import 'package:konig/widgets/category_chips.dart';
import 'package:konig/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomeView();
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final PageController _carouselController = PageController();
  int _currentSlide = 0;
  late Timer _timer;

  final List<Map<String, dynamic>> _slides = [
    {
      'image': 'assets/images/tomato.jpg',
      'tag': 'Limited Time 🔥',
      'title': 'Fresh Tomatoes',
      'subtitle': 'Up to 20% off on all tomatoes',
      'useImage': true,
    },
    {
      'image': null,
      'tag': 'New Arrivals 🌿',
      'title': 'Farm to Table',
      'subtitle': 'Freshly harvested vegetables daily',
      'useImage': false,
    },
    {
      'image': 'assets/images/pineapple.jpg',
      'tag': 'Best Seller ⭐',
      'title': 'Tropical Fruits',
      'subtitle': 'Exotic fruits from local farms',
      'useImage': true,
    },
  ];

  final List<Map<String, dynamic>> _topSellers = [
    {'name': 'Soya beans', 'price': 10, 'image': 'assets/images/soya_beans.jpg'},
    {'name': 'Potato', 'price': 10, 'image': 'assets/images/potato.jpg'},
    {'name': 'Apple', 'price': 10, 'image': 'assets/images/apple.jpg'},
  ];

  final List<Map<String, dynamic>> _recentlyAdded = [
    {'name': 'Pineapple', 'price': 10, 'image': 'assets/images/pineapple.jpg'},
    {'name': 'Garri', 'price': 10, 'image': 'assets/images/garri.jpg'},
    {'name': 'Water melon', 'price': 10, 'image': 'assets/images/water_melon.jpg'},
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_carouselController.hasClients) {
        final next = (_currentSlide + 1) % _slides.length;

        _carouselController.animateToPage(
          next,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F8F1),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _HomeHero(
              carouselController: _carouselController,
              slides: _slides,
              currentSlide: _currentSlide,
              onPageChanged: (i) => setState(() => _currentSlide = i),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 14,
                          sigmaY: 14,
                        ),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.black.withOpacity(0.28)
                                : Colors.white.withOpacity(0.62),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withOpacity(0.08)
                                  : Colors.white.withOpacity(0.70),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  isDark ? 0.16 : 0.05,
                                ),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextField(
                            style: TextStyle(
                              fontSize: 13,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search fruits, vegetables...',
                              hintStyle: TextStyle(
                                color: isDark ? Colors.grey[400] : Colors.grey[500],
                                fontSize: 13,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: isDark ? Colors.grey[400] : Colors.grey[500],
                                size: 20,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 14,
                        sigmaY: 14,
                      ),
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF16722D).withOpacity(0.86),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.28),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF16722D).withOpacity(0.24),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.tune,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 14, bottom: 4),
              child: CategoryChips(),
            ),
          ),

          SliverToBoxAdapter(
            child: _SectionHeader(
              title: 'Popular Products',
              onSeeAll: () {},
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => GestureDetector(
                  onTap: () {},
                  child: ProductCard(product: products[index]),
                ),
                childCount: products.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.82,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: _SectionHeader(
              title: 'Top Sellers',
              onSeeAll: () {},
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 165,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _topSellers.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) => _SmallCard(
                  item: _topSellers[index],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: _SectionHeader(
              title: 'Recently Added',
              onSeeAll: () {},
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 165,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _recentlyAdded.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) => _SmallCard(
                  item: _recentlyAdded[index],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 105),
          ),
        ],
      ),
    );
  }
}

class _HomeHero extends StatelessWidget {
  final PageController carouselController;
  final List<Map<String, dynamic>> slides;
  final int currentSlide;
  final ValueChanged<int> onPageChanged;

  const _HomeHero({
    required this.carouselController,
    required this.slides,
    required this.currentSlide,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: topPadding + 300,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: topPadding + 220,
            color: const Color(0xFF0F5A2E),
          ),

          Positioned(
            top: topPadding + 18,
            left: 18,
            right: 18,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Good Morning',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Andre 👋',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                _HeroIcon(
                  icon: Icons.notifications_outlined,
                  badge: true,
                  onTap: null,
                ),
                const SizedBox(width: 8),
                GetBuilder<ThemeController>(
                  builder: (controller) => _HeroIcon(
                    icon: controller.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    onTap: () => controller.toggleTheme(),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: topPadding + 170,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF121212) : const Color(0xFFF8F8F1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
            ),
          ),

          Positioned(
            top: topPadding + 95,
            left: 18,
            right: 18,
            child: _CarouselCard(
              controller: carouselController,
              slides: slides,
              currentSlide: currentSlide,
              onPageChanged: onPageChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool badge;

  const _HeroIcon({
    required this.icon,
    required this.onTap,
    this.badge = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 21,
            ),
          ),
          if (badge)
            Positioned(
              right: 9,
              top: 9,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CarouselCard extends StatelessWidget {
  final PageController controller;
  final List<Map<String, dynamic>> slides;
  final int currentSlide;
  final ValueChanged<int> onPageChanged;

  const _CarouselCard({
    required this.controller,
    required this.slides,
    required this.currentSlide,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.22),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            PageView.builder(
              controller: controller,
              itemCount: slides.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                final slide = slides[index];
                final useImage = slide['useImage'] as bool;

                return Container(
                  decoration: BoxDecoration(
                    image: useImage && slide['image'] != null
                        ? DecorationImage(
                            image: AssetImage(slide['image'] as String),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.35),
                              BlendMode.darken,
                            ),
                          )
                        : null,
                    gradient: !useImage
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF123D20),
                              Color(0xFF51A83F),
                            ],
                          )
                        : null,
                  ),
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFA726),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          slide['tag'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        slide['title'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        slide['subtitle'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            Positioned(
              bottom: 16,
              right: 16,
              child: Row(
                children: List.generate(
                  slides.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(left: 4),
                    width: currentSlide == index ? 18 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(
                        currentSlide == index ? 1.0 : 0.55,
                      ),
                      borderRadius: BorderRadius.circular(3),
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

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const _SectionHeader({
    required this.title,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          GestureDetector(
            onTap: onSeeAll,
            child: Text(
              'See All',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const _SmallCard({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 130,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(14),
            ),
            child: Image.asset(
              item['image'] as String,
              height: 95,
              width: 130,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 95,
                color: const Color(0xFFE8F5E9),
                child: const Center(
                  child: Icon(
                    Icons.image_outlined,
                    color: Colors.black26,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 7, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '\$${item['price']}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
