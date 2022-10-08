import 'package:asusu_igbo_f/shared/components/shared_components.dart';
import 'package:asusu_igbo_f/shared/styles/shared_colors.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          searchFormField(label: "Search", prefix: "assets/icons/A4logo.png"),
          // TODO: Use a carousel slider instead of a container.
          Container(
            height: 150,
            width: 350,
            decoration: const BoxDecoration(
                color: lavenderBlush,
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          SizedBox(
            child: Column(
              children: [
                Row(
                  children: [Container()],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
