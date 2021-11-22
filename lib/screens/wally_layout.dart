import 'package:flutter/material.dart';
import 'package:wally_app/controllers/wally_layout_controller.dart';

class WallyLayout extends StatefulWidget {
  const WallyLayout({Key? key}) : super(key: key);

  @override
  State<WallyLayout> createState() => _WallyLayoutState();
}

class _WallyLayoutState extends State<WallyLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallpaper App"),
      ),
      body: WallyLayoutController.item[WallyLayoutController.currentIndex].screen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: WallyLayoutController.currentIndex,
        onTap: (int newValue) {
          setState(() {
            WallyLayoutController.changeIndex(newValue);
          });
        },
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        items: WallyLayoutController.item
            .map(
              (element) => BottomNavigationBarItem(
                label: element.label,
                icon: element.icon,
              ),
            )
            .toList(),
      ),
    );
  }
}

// IndexedStack(
//         index: WallyLayoutController.index,
//         children: WallyLayoutController.item.map((e) => e.screen).toList(),
//       ),
