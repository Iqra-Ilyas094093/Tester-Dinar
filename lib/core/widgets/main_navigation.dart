// bottom naviagations route setup

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class MainNavigation extends StatelessWidget {
  final Widget child;
  const MainNavigation({super.key, required this.child});

  //  ONLY these 4 routes get the bottom nav
  static const List<String> _tabRoutes = [
    '/home',
    '/bookings',
    '/rewards',
    '/profile',
  ];

  static const List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home_rounded, 'label': 'Home', 'route': '/home'},
    {
      'icon': Icons.calendar_today_rounded,
      'label': 'Bookings',
      'route': '/bookings'
    },
    {'icon': Icons.star_rounded, 'label': 'Rewards', 'route': '/rewards'},
    {'icon': Icons.person_rounded, 'label': 'Profile', 'route': '/profile'},
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    // Check if current route is exactly one of the 4 tab routes
    final isTabRoute = _tabRoutes.any(
      (route) => location == route || location.startsWith('$route?'),
    );

    final currentIndex = _navItems.indexWhere(
      (item) => location.startsWith(item['route']),
    );

    return Scaffold(
      body: child,
      //  Only show bottom nav on the 4 tab routes
      bottomNavigationBar: isTabRoute
          ? BottomNavigationBar(
              currentIndex: currentIndex < 0 ? 0 : currentIndex,
              onTap: (index) {
                context.go(_navItems[index]['route']);
              },
              type: BottomNavigationBarType.fixed,
              items: _navItems.map((item) {
                return BottomNavigationBarItem(
                  icon: Icon(item['icon']),
                  label: item['label'],
                );
              }).toList(),
            )
          : null, // null = no bottom nav = no bar shown
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class MainNavigation extends StatefulWidget {
//   final Widget child;

//   const MainNavigation({
//     super.key,
//     required this.child,
//   });

//   @override
//   State<MainNavigation> createState() => _MainNavigationState();
// }

// class _MainNavigationState extends State<MainNavigation> {
//   int _currentIndex = 0;

//   final List<Map<String, dynamic>> _navItems = [
//     {'icon': Icons.home_rounded, 'label': 'Home', 'route': '/home'},
//     {'icon': Icons.calendar_today_rounded, 'label': 'Bookings', 'route': '/bookings'},
//     {'icon': Icons.star_rounded, 'label': 'Rewards', 'route': '/rewards'},
//     {'icon': Icons.person_rounded, 'label': 'Profile', 'route': '/profile'},
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//     context.go(_navItems[index]['route']);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Determine current index based on current route
//     final location = GoRouterState.of(context).uri.toString();
//     _currentIndex = _navItems.indexWhere((item) => location.contains(item['route']));
//     if (_currentIndex == -1) _currentIndex = 0;

//     return Scaffold(
//       body: widget.child,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onItemTapped,
//         type: BottomNavigationBarType.fixed,
//         items: _navItems.map((item) {
//           return BottomNavigationBarItem(
//             icon: Icon(item['icon']),
//             label: item['label'],
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
