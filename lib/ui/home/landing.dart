import 'package:asusu_igbo_f/shared/shared.dart';
import 'package:asusu_igbo_f/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/logic.dart';
import '../../shared/styles/shared_colors.dart' as a4_style;
import '../ui.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int selectedIndex = 0;

  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(FetchPromotedProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final customTextStyle = Theme.of(context).textTheme.titleSmall!.copyWith(
    //     fontWeight: FontWeight.w300,
    //     color: Theme.of(context).textTheme.titleSmall!.color!);
    return Container(
      color: a4_style.navPane,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: a4_style.smokyBlack,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(5),
            child: Container(
              color: a4_style.navPane,
            ),
          ),
          body: Center(
            child: _pages.elementAt(selectedIndex), //New
          ),
          bottomNavigationBar: CustomBottomNavigationBar(
            iconList: icons,
            onChange: _onItemTapped,
          ),
        ),
      ),
    );
  }

  static const List<Widget> _pages = <Widget>[
    Home(),
    Icon(
      Icons.camera,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
    ProfileScreen()
  ];

  static List<Widget> icons = <Widget>[
    Image.asset(
      'assets/icons/Menu.png',
      height: 35,
      width: 35,
    ),
    Image.asset(
      'assets/icons/cart.png',
      height: 35,
      width: 35,
    ),
    Image.asset(
      'assets/icons/A4logo.png',
      height: 35,
      width: 35,
    ),
    Image.asset(
      'assets/icons/connect.png',
      height: 35,
      width: 35,
    ),
    Image.asset(
      'assets/icons/profile.png',
      height: 35,
      width: 35,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
