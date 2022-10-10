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
  const Choice({
    required this.title,
    required this.icon,
    required this.goWhere,
    // this.context,
  });
  final String title;
  final IconData icon;
  final VoidCallback? goWhere;
  // final BuildContext? contextB;
}

List<Choice> choices = <Choice>[
  Choice(
      title: 'Tinye Okwu',
      icon: Icons.home,
      goWhere: () {
        print("Tinye Okwu Pressed");
      }),
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
                  // Expanded(child: choic),
                  Text(choice.title,
                      style: const TextStyle(color: lavenderBlush)),
                ]),
          ),
        ));
  }
}
