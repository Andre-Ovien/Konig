import 'dart:ui';

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final List<_ProfileAction> actions = const [
    _ProfileAction(
      title: 'Edit Profile',
      icon: Icons.manage_accounts_outlined,
    ),
    _ProfileAction(
      title: 'Notification',
      icon: Icons.notifications_none_rounded,
    ),
    _ProfileAction(
      title: 'Shipping Address',
      icon: Icons.location_on_outlined,
    ),
    _ProfileAction(
      title: 'Change Password',
      icon: Icons.lock_outline_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F8F1),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 112),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 130,
                  maxWidth: 430,
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.black.withOpacity(0.28)
                              : Colors.white.withOpacity(0.70),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: isDark
                                ? Colors.white.withOpacity(0.08)
                                : Colors.white.withOpacity(0.68),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(isDark ? 0.24 : 0.08),
                              blurRadius: 22,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 20),

                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 106,
                                  height: 106,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0xFF31B653),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/profile.jpg',
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        color: const Color(0xFFE8F5E9),
                                        child: const Icon(
                                          Icons.person_rounded,
                                          size: 54,
                                          color: const Color(0xFF31B653),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 5,
                                  bottom: 7,
                                  child: Container(
                                    width: 27,
                                    height: 27,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF31B653),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isDark
                                            ? const Color(0xFF121212)
                                            : Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.edit_rounded,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),
                            const Text(
                              'Andre',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Buyer',
                              style: TextStyle(
                                color: isDark ? Colors.grey[400] : Colors.grey[600],
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 26),

                            ...actions.map(
                              (action) => Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: _ProfileActionTile(action: action),
                              ),
                            ),

                            const SizedBox(height: 10),

                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.logout_rounded,
                                  size: 20,
                                ),
                                label: const Text(
                                  'Sign Out',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: const Color(0xFF31B653),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProfileActionTile extends StatelessWidget {
  final _ProfileAction action;

  const _ProfileActionTile({
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFF3A9F9A),
              shape: BoxShape.circle,
            ),
            child: Icon(
              action.icon,
              color: Colors.white,
              size: 21,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              action.title,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: isDark ? Colors.grey[400] : Colors.black87,
            size: 24,
          ),
        ],
      ),
    );
  }
}

class _ProfileAction {
  final String title;
  final IconData icon;

  const _ProfileAction({
    required this.title,
    required this.icon,
  });
}
