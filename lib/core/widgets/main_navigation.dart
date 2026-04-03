// bottom naviagations route setup
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

// MainNavigation is ONLY rendered inside the ShellRoute.
// That means it ONLY wraps: /home, /bookings, /rewards, /profile.
// No isTabRoute check needed — the router controls visibility.

class MainNavigation extends StatelessWidget {
  final Widget child;

  const MainNavigation({super.key, required this.child});

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
    final currentIndex = _navItems.indexWhere(
      (item) => location.startsWith(item['route']),
    );

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex < 0 ? 0 : currentIndex,
        onTap: (index) => context.go(_navItems[index]['route']),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.brandGold,
        items: _navItems
            .map((item) => BottomNavigationBarItem(
                  icon: Icon(item['icon']),
                  label: item['label'],
                ))
            .toList(),
      ),
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
