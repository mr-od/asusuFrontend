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
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: searchFormField(
              label: "Search", prefix: "assets/icons/A4logo.png"),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                color: amaranth,
                child: SelectCard(choice: choices[index]),
              );
            },
            childCount: choices.length,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 80.0),
        )
      ],
    );
    // SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       searchFormField(label: "Search", prefix: "assets/icons/A4logo.png"),
    //       // TODO: Use a carousel slider instead of a container.
    //       Container(
    //         height: 150,
    //         width: 350,
    //         decoration: const BoxDecoration(
    //             color: lavenderBlush,
    //             borderRadius: BorderRadius.all(Radius.circular(15))),
    //       ),

    //     ],
    //   ),
    // );
  }
}

class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'Home', icon: Icons.home),
  Choice(title: 'Contact', icon: Icons.contacts),
  Choice(title: 'Map', icon: Icons.map),
  Choice(title: 'Phone', icon: Icons.phone),
  Choice(title: 'Camera', icon: Icons.camera_alt),
  Choice(title: 'Setting', icon: Icons.settings),
  Choice(title: 'Album', icon: Icons.photo_album),
  Choice(title: 'WiFi', icon: Icons.wifi),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: pureBlack,
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Icon(choice.icon, size: 50.0, color: lavenderBlush)),
                Text(choice.title,
                    style: const TextStyle(color: lavenderBlush)),
              ]),
        ));
  }
}
