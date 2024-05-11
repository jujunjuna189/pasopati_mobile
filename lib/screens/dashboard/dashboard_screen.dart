import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:pro_mobile/repository/auth_repo.dart';
import 'package:pro_mobile/repository/feature_repo.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/widgets/toast/toast_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _textMarquee = "Selamat Datang Di Aplikasi Pasopati";
  List _dashboardSlider = [];

  @override
  void initState() {
    super.initState();
    getFirstData();
  }

  void getFirstData() async {
    await getTextMarque();
    await getSlider();
    setState(() {});
  }

  Future getTextMarque() async {
    await FeatureRepo.instance.dashboardTextMarquee({}).then((value) {
      _textMarquee = value[0]['text'];
    });
  }

  Future getSlider() async {
    await FeatureRepo.instance.dashboardSlider({}).then((value) {
      _dashboardSlider = value;
    });
  }

  void alarmNavigation() async {
    AuthRepo.instance.getSession("user").then((value) {
      if (value['role'] == 1 || value['role'] == '1') {
        Navigator.of(context).pushNamed("/alarm");
      } else {
        ToastAlert.instance.showMessage(
            customMessage: true, customMessageText: "Hanya yang berwenang");
      }
    });
  }

  void launchURL(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: const BoxDecoration(
            color: bgLightTransparent,
          ),
          child: SizedBox(
            height: 40.0,
            child: Marquee(
              text: " $_textMarquee",
              style: const TextStyle(fontWeight: FontWeight.bold),
              scrollAxis: Axis.horizontal,
            ),
          ),
        ),
        _dashboardSlider.isNotEmpty
            ? CarouselSlider(
                items: _dashboardSlider.map((value) {
                  return Builder(builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            value['path'],
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    );
                  });
                }).toList(),
                options: CarouselOptions(
                  height: 200,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
              )
            : Container(),
        const SizedBox(
          height: 5,
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                    color: bgLightTransparent,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (() {
                              alarmNavigation();
                            }),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              decoration: BoxDecoration(
                                color: bgWhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.asset(
                                          "assets/images/icon/alarm.png")),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Alarm Stelling",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "Sirine Kesiapsiagaan",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: (() {
                              Navigator.of(context).pushNamed("/permission");
                            }),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              decoration: BoxDecoration(
                                color: bgWhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.asset(
                                          "assets/images/icon/soldier.png")),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Perizinan",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "Keluar Masuk Ksatrian",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (() {
                              Navigator.of(context)
                                  .pushNamed("/vehicle_van_permission");
                            }),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              decoration: BoxDecoration(
                                color: bgWhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.asset(
                                          "assets/images/icon/armored-vehicle.png")),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Kendaraan",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "Keluar Masuk Kendaraan",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: (() {
                              Navigator.of(context).pushNamed("/suggestion");
                            }),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              decoration: BoxDecoration(
                                color: bgWhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.asset(
                                          "assets/images/icon/letterbox.png")),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Saran dan Masukan",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "Kirim Saran dan Masukan",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (() {
                              Navigator.of(context).pushNamed("/staff");
                            }),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              decoration: BoxDecoration(
                                color: bgWhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.asset(
                                          "assets/images/icon/identification-card.png")),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Staff",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "Data Staff",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: (() {
                              Navigator.of(context).pushNamed("/ability_data");
                            }),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              decoration: BoxDecoration(
                                color: bgWhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.asset(
                                          "assets/images/icon/army.png")),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Kemampuan",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "Data Kemampuan Personil",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                color: bgWhite, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Halaman Website",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (() {
                    launchURL(
                        "https://tniad.mil.id");
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: const BoxDecoration(
                      color: bgWhite,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 33,
                                  height: 33,
                                  child: Image.asset(
                                      "assets/images/logo/tni_ad.png")),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "TNI Angkatan Darat",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 2,
                  color: Colors.black12,
                ),
                GestureDetector(
                  onTap: (() {
                    launchURL(
                        "https://kostrad.mil.id");
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: const BoxDecoration(
                      color: bgWhite,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 33,
                                  height: 33,
                                  child: Image.asset(
                                      "assets/images/logo/kostrad.png")),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Kostrad",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 2,
                  color: Colors.black12,
                ),
                GestureDetector(
                  onTap: (() {
                    launchURL("https://tni.mil.id");
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: const BoxDecoration(
                      color: bgWhite,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 33,
                                  height: 33,
                                  child: Image.asset(
                                      "assets/images/logo/gold.jpg")),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "TNI",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 2,
                  color: Colors.black12,
                ),
                GestureDetector(
                  onTap: (() {
                    launchURL("https://www.detik.com");
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: const BoxDecoration(
                      color: bgWhite,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 33,
                                  height: 33,
                                  child: Image.asset(
                                      "assets/images/logo/detik.png")),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Detik.com",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 2,
                  color: Colors.black12,
                ),
                GestureDetector(
                  onTap: (() {
                    launchURL("https://www.kompas.com/");
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: const BoxDecoration(
                      color: bgWhite,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 33,
                                  height: 33,
                                  child: Image.asset(
                                      "assets/images/logo/kompas.png")),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Kompas",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 2,
                  color: Colors.black12,
                ),
                GestureDetector(
                  onTap: (() {
                    launchURL("https://okezone.com/");
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: const BoxDecoration(
                      color: bgWhite,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 33,
                                  height: 33,
                                  child: Image.asset(
                                      "assets/images/logo/okezone.png")),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Okezone",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 2,
                  color: Colors.black12,
                ),
                GestureDetector(
                  onTap: (() {
                    launchURL("https://www.tribunnews.com/");
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: const BoxDecoration(
                      color: bgWhite,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 33,
                                  height: 33,
                                  child: Image.asset(
                                      "assets/images/logo/tribun.png")),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Tribun",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                color: bgWhite, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sosial Media",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (() {
                    launchURL(
                        "https://www.instagram.com/penpussenarmed?igsh=cTF6OGNoOHZkZzJy");
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: const BoxDecoration(
                      color: bgWhite,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 33,
                                  height: 33,
                                  child: Image.asset(
                                      "assets/images/logo/pussenarmed.png")),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Pussenarmed",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 2,
                  color: Colors.black12,
                ),
                GestureDetector(
                  onTap: (() {
                    launchURL(
                        "https://www.instagram.com/tni_angkatan_darat?igsh=MXRzNTM0Nzl4ZDdv");
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: const BoxDecoration(
                      color: bgWhite,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 33,
                                  height: 33,
                                  child: Image.asset(
                                      "assets/images/logo/tni_ad.png")),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "TNI Angkatan Darat",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 2,
                  color: Colors.black12,
                ),
                GestureDetector(
                  onTap: (() {
                    launchURL(
                        "https://www.instagram.com/penkostrad?igsh=dXduZzc4dWw1djhk");
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: const BoxDecoration(
                      color: bgWhite,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 33,
                                  height: 33,
                                  child: Image.asset(
                                      "assets/images/logo/kostrad.png")),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Kostrad",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 2,
                  color: Colors.black12,
                ),
                GestureDetector(
                  onTap: (() {
                    launchURL("https://www.instagram.com/puspentni?igsh=MWRjbG5sanJ1dmF1bQ==");
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: const BoxDecoration(
                      color: bgWhite,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 33,
                                  height: 33,
                                  child: Image.asset(
                                      "assets/images/logo/gold.jpg")),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "TNI",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 2,
                  color: Colors.black12,
                ),
                GestureDetector(
                  onTap: (() {
                    launchURL("https://youtube.com/@batalyonarmed9?si=8J7wLLUa5yjTrGMf");
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: const BoxDecoration(
                      color: bgWhite,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 33,
                                  height: 33,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                        "assets/images/logo/yt-yon.png"),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Yonarmed 9 Pasopati",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 2,
                  color: Colors.black12,
                ),
                GestureDetector(
                  onTap: (() {
                    launchURL("https://www.instagram.com/batalyonarmed9?igsh=MWwwYjM5NzB0dXN4cw==");
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: const BoxDecoration(
                      color: bgWhite,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 33,
                                  height: 33,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(
                                        "assets/images/logo/ig-yon.png"),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Yonarmed 9 Pasopati",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
