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
  late ProductBloc bloc;
  late CartBloc cBloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ProductBloc>(context);
    cBloc = BlocProvider.of<CartBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
    cBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: a4_style.navPane,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: a4_style.smokyBlack,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Container(
              color: a4_style.eerieBlack,
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

  static final List<Widget> _pages = <Widget>[
    Home(),
    const CartScreen(),
    const Icon(
      Icons.camera,
      size: 150,
    ),
    const Icon(
      Icons.chat,
      size: 150,
    ),
    const ProfileScreen()
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
