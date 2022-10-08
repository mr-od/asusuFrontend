// ignore_for_file: library_private_types_in_public_api

import 'package:asusu_igbo_f/shared/styles/shared_colors.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;
  final List<Widget> iconList;

  const CustomBottomNavigationBar(
      {Key? key,
      this.defaultSelectedIndex = 0,
      required this.iconList,
      required this.onChange})
      : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  List<Widget> _iconList = [];

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.defaultSelectedIndex;
    _iconList = widget.iconList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> navBarItemList = [];

    for (var i = 0; i < _iconList.length; i++) {
      navBarItemList.add(buildNavBarItem(_iconList[i], i));
    }

    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: pureBlack,
      child: Row(
        children: navBarItemList,
      ),
    );
  }

  Widget buildNavBarItem(Widget icon, int index) {
    return GestureDetector(
      onTap: () {
        widget.onChange(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / _iconList.length,
        decoration: index == _selectedIndex
            ? BoxDecoration(
                border: const Border(
                  bottom: BorderSide(width: 4, color: amaranth),
                ),
                gradient: LinearGradient(colors: [
                  amaranth.withOpacity(0.3),
                  amaranth.withOpacity(0.015),
                  pureBlack.withOpacity(0.3),
                  pureBlack.withOpacity(0.015)
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)
                // color: index == _selectedItemIndex ? Colors.green : Colors.white,
                )
            : const BoxDecoration(),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: index == _selectedIndex ? pureBlack : smokyBlack,
              ),
              child: icon,
            ),
            const Text('')
          ],
        ),
      ),
    );
  }
}
