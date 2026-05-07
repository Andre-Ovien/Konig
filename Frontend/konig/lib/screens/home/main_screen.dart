import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konig/controllers/navigation_controller.dart';
import 'package:konig/screens/home/hm_screen.dart';
import 'package:konig/controllers/theme_controller.dart';
import 'package:konig/widgets/custom_bottom_navbar.dart';
import '../shop/shop_screen.dart';
import '../cart/cart_screen.dart';
import '../orders/orders_screen.dart';
import '../profile/profile_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController = Get.find<NavigationController>();
    return GetBuilder<ThemeController>(
        builder: (themeController)=> Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Obx(
            () => IndexedStack(
              key: ValueKey(navigationController.currentIndex.value),
              index: navigationController.currentIndex.value,
              children:const [
                HomeScreen(),
                ShopScreen(),
                CartScreen(),
                OrdersScreen(),
                ProfileScreen(),  
              ], 
            )
          ),
        ),
        bottomNavigationBar: const CustomBottomNavbar(),
      ),
    );
  }
}