import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:konig/utils/app_textstyles.dart';

class CategoryChips extends StatefulWidget {
  const CategoryChips({super.key});

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  int selectIndex = 0;

  final List<Map<String, dynamic>> categoryItems = const [
    {
      'label': 'All',
      'icon': Icons.grid_view_rounded,
    },
    {
      'label': 'Fruits',
      'icon': Icons.local_grocery_store_rounded,
    },
    {
      'label': 'Vegetables',
      'icon': Icons.eco_rounded,
    },
    {
      'label': 'Grains',
      'icon': Icons.grain_rounded,
    },
    {
      'label': 'Herbs',
      'icon': Icons.spa_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categoryItems.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = selectIndex == index;
          final category = categoryItems[index];

          return ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 12,
                sigmaY: 12,
              ),
              child: ChoiceChip(
                selected: isSelected,
                onSelected: (bool selected) {
                  if (!selected) return;

                  setState(() {
                    selectIndex = index;
                  });
                },
                avatar: Icon(
                  category['icon'] as IconData,
                  size: 16,
                  color: isSelected
                      ? Colors.white
                      : isDark
                          ? Colors.grey[300]
                          : Colors.grey[600],
                ),
                label: Text(
                  category['label'] as String,
                  style: AppTextStyle.withColor(
                    isSelected
                        ? AppTextStyle.withWeight(
                            AppTextStyle.bodySmall,
                            FontWeight.w700,
                          )
                        : AppTextStyle.bodySmall,
                    isSelected
                        ? Colors.white
                        : isDark
                            ? Colors.grey[300]!
                            : Colors.grey[600]!,
                  ),
                ),
                selectedColor: primaryColor.withOpacity(0.88),
                backgroundColor: isDark
                    ? Colors.black.withOpacity(0.24)
                    : Colors.white.withOpacity(0.58),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                elevation: isSelected ? 2 : 0,
                pressElevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                labelPadding: const EdgeInsets.only(
                  left: 2,
                  right: 6,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                side: BorderSide(
                  color: isSelected
                      ? Colors.white.withOpacity(0.22)
                      : isDark
                          ? Colors.white.withOpacity(0.08)
                          : Colors.white.withOpacity(0.62),
                  width: 1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
