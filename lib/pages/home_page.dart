import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../configs/user_prefs_config.dart';
import '../widgets/AppBars/appbar_wd.dart';
import '../widgets/drawer_widget.dart';
import 'counter_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller = PageController(initialPage: 0);
  int positionPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          title: 'Home Page',
        ),
        drawer: Consumer<UserPrefsConfig>(builder: (context, prefs, child) {
          return DrawerWidget(imagePath: prefs.image, userName: prefs.userName, email: prefs.email);
        }),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    positionPage = value;
                  });
                },
                children: [
                  CounterPage(),
                  Container(),
                ],
              ),
            ),
            BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  controller.jumpToPage(value);
                },
                currentIndex: positionPage,
                items: [
                  BottomNavigationBarItem(label: "Counter", icon: Icon(Icons.numbers)),
                  BottomNavigationBarItem(label: "Undefined", icon: Icon(Icons.warning_rounded)),
                ])
          ],
        ),
      ),
    );
  }
}
