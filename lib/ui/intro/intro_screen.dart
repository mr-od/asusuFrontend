import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../shared/styles/shared_colors.dart' as a4_style;
import '../ui.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  _IntroScreenState();

  bool clicked = false;

  void afterIntroComplete() {
    setState(() {
      clicked = true;
    });
  }

  final List<PageViewModel> pages = [
    PageViewModel(
        titleWidget: Column(
          children: <Widget>[
            const Text(
              'Improve and Maintain the igbo language',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: a4_style.lavenderBlush),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 3,
              width: 100,
              decoration: BoxDecoration(
                  color: a4_style.lavenderBlush,
                  borderRadius: BorderRadius.circular(10)),
              child: const Divider(color: a4_style.amaranth),
            )
          ],
        ),
        bodyWidget: const Text(
          "Zọpụta asụsụ ịgbọ",
          textAlign: TextAlign.center,
          style: TextStyle(color: a4_style.lavenderBlush),
        ),
        image: Image.asset('assets/icons/A4logo.png')),
    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          const Text(
            'Help Verify New Igbo Words',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: a4_style.lavenderBlush),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
                color: a4_style.lavenderBlush,
                borderRadius: BorderRadius.circular(10)),
            child: const Divider(color: a4_style.amaranth),
          )
        ],
      ),
      bodyWidget: Column(
        children: [
          const Text(
            "Nyochaa okwu igbo",
            textAlign: TextAlign.center,
            style: TextStyle(color: a4_style.lavenderBlush),
          ),
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            'assets/icons/A4logo.png',
            height: 50,
            width: 50,
          )
        ],
      ),
      // body: "Most things do not have Igbo Words",
      image: Image.asset(
        'assets/icons/verify_w.png',
        height: 100,
        width: 100,
      ),
    ),
    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          const Text(
            'Become an Igbo Language Moderator',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: a4_style.lavenderBlush),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
                color: a4_style.lavenderBlush,
                borderRadius: BorderRadius.circular(10)),
            child: const Divider(color: a4_style.amaranth),
          )
        ],
      ),
      bodyWidget: Column(
        children: [
          const Text(
            "Nyere aka sụgharịa ufodu okwu na asụsụ igbo",
            textAlign: TextAlign.center,
            style: TextStyle(color: a4_style.lavenderBlush),
          ),
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            'assets/icons/A4logo.png',
            height: 50,
            width: 50,
          )
        ],
      ),
      // body: "Apply for igbo words to be assigned to some objects or things.",
      image: Image.asset(
        'assets/icons/insert_w.png',
        height: 100,
        width: 100,
      ),
    ),
    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          const Text(
            'Buy & Sell Igbo Cultural Products',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: a4_style.lavenderBlush),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
                color: a4_style.lavenderBlush,
                borderRadius: BorderRadius.circular(10)),
            child: const Divider(color: a4_style.amaranth),
          )
        ],
      ),
      bodyWidget: Column(
        children: [
          const Text(
            "ịzụrụ na ire ngwaahịa ọmenala ndị igbo dịka ákwà, ịhe oriri, ọgwụ e ji agwọ oria, akwụkwọ, ịhe egwú etc.",
            textAlign: TextAlign.center,
            style: TextStyle(color: a4_style.lavenderBlush),
          ),
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            'assets/icons/A4logo.png',
            height: 50,
            width: 50,
          )
        ],
      ),
      image: Image.asset(
        'assets/icons/afia.png',
        height: 100,
        width: 100,
      ),
    ),
    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          const Text(
            'Get to Remember Igbo Festivals & Events',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: a4_style.lavenderBlush),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
                color: a4_style.lavenderBlush,
                borderRadius: BorderRadius.circular(10)),
            child: const Divider(color: a4_style.amaranth),
          )
        ],
      ),
      bodyWidget: Column(
        children: [
          const Text(
            "Ememe ndị igbo niile na otu APP, ka ị ghara ichefu.",
            textAlign: TextAlign.center,
            style: TextStyle(color: a4_style.lavenderBlush),
          ),
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            'assets/icons/A4logo.png',
            height: 50,
            width: 50,
          )
        ],
      ),
      image: Image.asset(
        'assets/icons/fireworks.png',
        height: 100,
        width: 100,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return clicked
        ? LoginScreen()
        : IntroductionScreen(
            globalBackgroundColor: a4_style.pureBlack,
            pages: pages,
            onDone: () {
              afterIntroComplete();
            },
            onSkip: () {
              afterIntroComplete();
            },
            showSkipButton: true,
            skip: const Text('Skip',
                style: TextStyle(
                    color: a4_style.lavenderBlush,
                    fontWeight: FontWeight.w600)),
            next: const Icon(
              Icons.navigate_next,
              color: a4_style.amaranth,
            ),
            done: const Text('Done',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: a4_style.lavenderBlush)),
            dotsDecorator: DotsDecorator(
                color: a4_style.lavenderBlush,
                activeColor: a4_style.amaranth,
                size: const Size.square(8),
                activeSize: const Size(20.0, 5.0),
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0))));
  }
}
