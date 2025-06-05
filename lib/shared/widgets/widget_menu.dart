import 'package:flutter/material.dart';
import 'package:booklog/config/routes.dart';

class MenuItemData {
  final IconData icon;
  final String label;
  final String routeName;

  MenuItemData({required this.icon, required this.label, required this.routeName});
}

class WidgetMenu extends StatefulWidget {
  const WidgetMenu({super.key});

  @override
  State<WidgetMenu> createState() => _WidgetMenuState();
}

class _WidgetMenuState extends State<WidgetMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isOpen = false;
  bool get _isUserLoggedIn {
    // TO-DO: implement test auth logic
    return true;
  }

  List<MenuItemData> get _currentMenuItems {
    if (_isUserLoggedIn) {
      return [
        MenuItemData(icon: Icons.home, label: 'Home', routeName: Routes.home),
        MenuItemData(icon: Icons.search, label: 'Search', routeName: Routes.search),
        MenuItemData(icon: Icons.my_library_books, label: 'My Collection', routeName: Routes.booklist),
        MenuItemData(icon: Icons.bar_chart, label: 'Statistics', routeName: Routes.statistics),
        MenuItemData(icon: Icons.bookmark_add, label: 'Wishlist', routeName: Routes.wishlist),
        MenuItemData(icon: Icons.settings, label: 'Settings', routeName: Routes.settings),
      ];
    } else {
      // Certifique-se de que Routes.login e Routes.signIn estão definidos em booklog/config/routes.dart
      return [
        MenuItemData(icon: Icons.home, label: 'Home', routeName: Routes.home),
        MenuItemData(icon: Icons.login, label: 'Login', routeName: Routes.login), // Ex: Routes.login
        MenuItemData(icon: Icons.person_add, label: 'Sign Up', routeName: Routes.registerUser), // Ex: Routes.signIn
      ];
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Widget _buildGridMenuItem(MenuItemData item) {
    return GestureDetector(
      onTap: () {
        _toggleMenu();
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushNamed(context, item.routeName);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item.icon, color: Colors.white, size: 20),
          const SizedBox(height: 4),
          Text(
        item.label,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 10),
        overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const int crossAxisCount = 3;

    final List<MenuItemData> menuItemsToDisplay = _currentMenuItems;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_isOpen)
          FadeTransition(
            opacity: _animation,
            child: ScaleTransition(
              scale: _animation,
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10, top: 50, left: 50),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 8, 7, 13),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.1,
                  children: menuItemsToDisplay.map(_buildGridMenuItem).toList(),
                ),
              ),
            ),
          ),
        FloatingActionButton(
          onPressed: _toggleMenu,
          backgroundColor: Colors.amber,
          heroTag: "main_fab_toggle",
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animation,
            color: Colors.black 
          ),
        ),
      ],
    );
  }
}