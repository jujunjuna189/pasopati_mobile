import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/armed_repo.dart';
import 'package:pro_mobile/repository/kostrad_repo.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/widgets/shimmer/shimmer_widget.dart';
import 'package:pro_mobile/widgets/text_field/field_search.dart';

class PositionScreen extends StatefulWidget {
  const PositionScreen({Key? key}) : super(key: key);

  @override
  State<PositionScreen> createState() => _PositionScreenState();
}

class _PositionScreenState extends State<PositionScreen> {
  bool _statusLoadPosition = false;
  List _positionList = [];
  List _kostradList = [];
  List _armedList = [];
  int _navigation = 1; //Navigation kostrad or armed

  @override
  void initState() {
    getKostrad();
    getArmed();
    super.initState();
  }

  void getKostrad() async {
    await KostradRepo.instance.show({}).then((value) {
      if (value != false) {
        _kostradList = value;
      }
    });
    setNavigation(1);
  }

  void getArmed() async {
    await ArmedRepo.instance.show({}).then((value) {
      _armedList = value;
    });
  }

  void onSearch(String searchValue) {
    if (_navigation == 1) {
      _positionList = _kostradList
          .where((value) =>
              value['nama']!
                  .toLowerCase()
                  .contains(searchValue.toLowerCase()) ||
              value['jabatan']!
                  .toLowerCase()
                  .contains(searchValue.toLowerCase()))
          .toList();
    } else if (_navigation == 2) {
      _positionList = _armedList
          .where((value) =>
              value['nama']!
                  .toLowerCase()
                  .contains(searchValue.toLowerCase()) ||
              value['jabatan']!
                  .toLowerCase()
                  .contains(searchValue.toLowerCase()))
          .toList();
    }
    setState(() {});
  }

  void setNavigation(int navigation) {
    _navigation = navigation;
    if (navigation == 1) {
      _positionList = _kostradList;
    } else if (navigation == 2) {
      _positionList = _armedList;
    } else {
      _positionList = [];
    }
    _statusLoadPosition = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FieldSearch(
          onChange: ((value) {
            onSearch(value);
          }),
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: (() {
                  setNavigation(1);
                }),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: _navigation == 1 ? bgWhite : bgLightPrimary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/position/kostrad50.png"),
                      const Text(
                        "Kostrad",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: (() {
                  setNavigation(2);
                }),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: _navigation == 2 ? bgWhite : bgLightPrimary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/position/armed50.png"),
                      const Text(
                        "Armed",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: !_statusLoadPosition
              ? buildPositionListShimmer()
              : buildPositionList(),
        ),
      ],
    );
  }

  Widget buildPositionListShimmer() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 8,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                color: bgWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget.circular(
                      height: 16,
                      width: double.infinity,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  const SizedBox(
                    height: 3,
                  ),
                  ShimmerWidget.circular(
                      height: 16,
                      width: 150,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                ],
              )),
        );
      },
    );
  }

  Widget buildPositionList() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: _positionList.isNotEmpty
          ? _positionList.map((value) {
              return ClipRRect(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: GestureDetector(
                    onTap: (() {
                      Navigator.of(context).pushNamed("/detail_kostrad",
                          arguments: jsonEncode({
                            ...value,
                            "title": _navigation == 1
                                ? "Penjabat Kostrad"
                                : "Pejabat Armed"
                          }));
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: BoxDecoration(
                        color: bgWhite,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value['jabatan'] ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(value['nama'] ?? ''),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList()
          : [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                  color: bgWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Tidak ada data",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
    );
  }
}
