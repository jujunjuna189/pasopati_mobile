import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/auth_repo.dart';
import 'package:pro_mobile/screens/calendar/calendar_screen.dart';
import 'package:pro_mobile/screens/dashboard/dashboard_screen.dart';
import 'package:pro_mobile/screens/information/information_screen.dart';
import 'package:pro_mobile/screens/learning/learning_screen.dart';
import 'package:pro_mobile/screens/position/position_screen.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/widgets/background/background_scafold.dart';
import 'package:pro_mobile/widgets/notification/notif_notification.dart';
import 'package:pro_mobile/widgets/popup/popup_profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> _user = {};
  String _titleScreen = '';
  int _currenTab = 0;
  final PageStorageBucket _bucket = PageStorageBucket();
  Widget _currentScreen = const DashboardScreen();

  final List<Map<String, dynamic>> _tabModel = [
    {
      'tab_name': 'Home',
      'tab_icon': Icons.home,
      'tab_screen': const DashboardScreen(),
    },
    {
      'tab_name': 'Pejabat',
      'tab_icon': Icons.person,
      'tab_screen': const PositionScreen(),
    },
    {
      'tab_name': 'Learning',
      'tab_icon': Icons.dashboard,
      'tab_screen': const LearningScreen(),
    },
    {
      'tab_name': 'Kalender',
      'tab_icon': Icons.calendar_month,
      'tab_screen': const CalendarScreen(),
    },
    {
      'tab_name': 'Informasi',
      'tab_icon': Icons.info,
      'tab_screen': const InformationScreen(),
    },
  ];

  void tabNavigator(tab) {
    _currenTab = tab;
    _titleScreen = _tabModel[tab]['tab_name'];
    _currentScreen = _tabModel[tab]['tab_screen'];
  }

  @override
  void initState() {
    _titleScreen = widget.title;
    getUser();
    super.initState();
  }

  void getUser() async {
    await AuthRepo.instance.getSession("user").then((value) {
      setState(() {
        _user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                    width: 23,
                    height: 23,
                    child: Image.asset(
                        "assets/images/logo/c.png")),
                const SizedBox(width: 5,),
                Text(_titleScreen),
              ],
            ),
            Row(
              children: [
                const NotifNotification(),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: (() {
                    PopupProfile.instance.showPopup(context);
                  }),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: bgLightPrimary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          _user['name'] != null
                              ? _user['name'].substring(0, 2)
                              : "Nama".substring(0, 2),
                          style: const TextStyle(
                              color: textDark,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          const BackgroundScafold(),
          PageStorage(
            bucket: _bucket,
            child: _currentScreen,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 60,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _tabModel.asMap().entries.map((val) {
                return MaterialButton(
                  minWidth: 40,
                  onPressed: (() {
                    setState(() {
                      tabNavigator(val.key);
                    });
                  }),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        val.value['tab_icon'],
                        size: 23,
                        color:
                            _currenTab == val.key ? textLight : textSoftLight,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        val.value['tab_name'],
                        style: TextStyle(
                            color: _currenTab == val.key
                                ? textLight
                                : textSoftLight,
                            fontSize: 10),
                      ),
                    ],
                  ),
                );
              }).toList()),
        ),
      ),
    );
  }
}
