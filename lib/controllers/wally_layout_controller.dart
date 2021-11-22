import 'package:flutter/material.dart';
import 'package:wally_app/screens/account_screen.dart';
import 'package:wally_app/screens/favorite_screen.dart';
import 'package:wally_app/screens/exploar_screen.dart';

class _BoardingItem {
  final String label;
  final Icon icon;
  final Widget screen;

  _BoardingItem({
    required this.label,
    required this.icon,
    required this.screen,
  });
}

class WallyLayoutController {
  static int currentIndex = 0;
  static List<_BoardingItem> item = [
    _BoardingItem(label: "Home", icon: Icon(Icons.search), screen: ExploarScreen()),
    _BoardingItem(label: "Favorite", icon: Icon(Icons.favorite), screen: FavoriteScreen()),
    _BoardingItem(label: "Account", icon: Icon(Icons.person), screen: AccountScreen()),
  ];

  static void changeIndex(int newIndex) {
    currentIndex = newIndex;
  }
}
