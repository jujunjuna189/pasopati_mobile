import 'package:flutter/material.dart';
import 'package:pro_mobile/screens/learning/article/article_screen.dart';
import 'package:pro_mobile/screens/learning/bujuk/bujuk_screen.dart';
import 'package:pro_mobile/screens/learning/e_learning/e_learning_screen.dart';
import 'package:pro_mobile/utils/colors.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({Key? key}) : super(key: key);

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: ColoredBox(
          color: bgSuccess,
          child: TabBar(
            controller: _controller,
            indicatorWeight: 3.0,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: const [
              Tab(
                text: "Artikel",
              ),
              Tab(
                text: "E-Learning",
              ),
              Tab(
                text: "Bujuk",
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          ArticleScreen(),
          ELearningScreen(),
          BujukScreen(),
        ],
      ),
    );
  }
}
