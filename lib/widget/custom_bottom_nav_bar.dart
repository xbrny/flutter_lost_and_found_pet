import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lost_found_pet_prototype/view_model/tab_model.dart';
import 'package:provider/provider.dart';

class NavItem {
  final String text;
  final IconData icon;
  NavItem(this.text, this.icon);
}

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _tabNotifier = Provider.of<TabModel>(context);
    final _currentUser = Provider.of<FirebaseUser>(context);

    final _navItem = <NavItem>[
      NavItem('Lost', LineIcons.binoculars),
      NavItem('Found', LineIcons.paw),
    ];

    if (_currentUser != null) {
      _navItem.add(NavItem('Profile', LineIcons.user));
    }

    List<BottomNavigationBarItem> _buildNavItem(List<NavItem> navItem) {
      return navItem
          .map((item) => BottomNavigationBarItem(
                icon: Icon(
                  item.icon,
                ),
                title: Text(item.text),
              ))
          .toList();
    }

    return BottomNavigationBar(
      currentIndex: _tabNotifier.currentTab,
      onTap: _tabNotifier.setTab,
      items: _buildNavItem(_navItem),
    );
  }
}
