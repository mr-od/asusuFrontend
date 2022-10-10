import 'package:asusu_igbo_f/shared/components/shared_components.dart';
import 'package:asusu_igbo_f/shared/styles/shared_colors.dart';
import 'package:asusu_igbo_f/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'http://afia4.oss-cn-beijing.aliyuncs.com/sliders/1.jpg',
      'http://afia4.oss-cn-beijing.aliyuncs.com/sliders/2.jpg',
    ];
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: searchFormField(
              label: "Search", prefix: "assets/icons/A4logo.png"),
        ),
        SliverToBoxAdapter(
            child: CarouselSlider(
          options: CarouselOptions(),
          items: imgList
              .map((item) => Center(
                  child: Image.network(item, fit: BoxFit.cover, width: 1000)))
              .toList(),
        )),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const PromotedProducts();
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    // color: amaranth,
                    child: SelectCard(choice: choices[index]),
                  ),
                ),
              );
            },
            childCount: choices.length,
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.only(bottom: 80.0),
        )
      ],
    );
  }
}

class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final Widget icon;
}

List<Choice> choices = <Choice>[
  Choice(
      title: 'New Word',
      icon: Image.asset(
        "assets/icons/insert_w.png",
        height: 50,
        width: 50,
      )),
  Choice(
      title: 'Verify Word',
      icon: Image.asset(
        "assets/icons/verify_w.png",
        height: 50,
        width: 50,
      )),
  Choice(
      title: 'Market',
      icon: Image.asset(
        "assets/icons/afia.png",
        height: 50,
        width: 50,
      )),
  Choice(
      title: 'Festival',
      icon: Image.asset(
        "assets/icons/fireworks.png",
        height: 50,
        width: 50,
      )),
  Choice(
      title: 'History',
      icon: Image.asset(
        "assets/icons/history.png",
        height: 50,
        width: 50,
      )),
  Choice(
      title: 'Food',
      icon: Image.asset(
        "assets/icons/nri.png",
        height: 50,
        width: 50,
      )),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: lavenderBlush, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        color: pureBlack,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: choice.icon),
                  Text(choice.title,
                      style: const TextStyle(color: lavenderBlush)),
                ]),
          ),
        ));
  }
}
