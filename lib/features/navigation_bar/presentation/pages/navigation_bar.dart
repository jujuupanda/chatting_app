import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key, required this.child});

  final StatefulNavigationShell child;

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int currentIndex = 0;

  onTap(int index) {
    setState(() {
      currentIndex = index;
    });
    widget.child.goBranch(index);
  }

  bottomNavigationBarItem() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_filled),
        activeIcon: Icon(
          Icons.home_filled,
          color: Colors.blueAccent,
        ),
        label: "Home",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.search_rounded),
        activeIcon: Icon(
          Icons.search_rounded,
          color: Colors.blueAccent,
        ),
        label: "Search",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.email_rounded),
        activeIcon: Icon(
          Icons.email_rounded,
          color: Colors.blueAccent,
        ),
        label: "Message",
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person_rounded),
        activeIcon: Icon(
          Icons.person_rounded,
          color: Colors.blueAccent,
        ),
        label: "Me",
      ),
    ];
  }

  bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (value) => onTap(value),
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: bottomNavigationBarItem(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
}
