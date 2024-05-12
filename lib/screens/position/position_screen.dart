import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/position_repo.dart';
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
  Map<String, dynamic> _currentTab = {
      "tabKey": 1,
      "image": "assets/images/position/kostrad50.png",
      "title": 'Kostrad',
      "isActive": true,
    };
  List<Map<String, dynamic>> _tabData = [
    {
      "tabKey": 1,
      "image": "assets/images/position/kostrad50.png",
      "title": 'Kostrad',
      "satuan": "kostrad",
      "isActive": true,
    },
    {
      "tabKey": 2,
      "image": "assets/images/position/armed50.png",
      "title": 'Armed',
      "isActive": false,
    },
    {
      "tabKey": 3,
      "image": "assets/images/position/armed50.png",
      "title": 'Devif 1 Kostrad',
      "isActive": false,
    },
    {
      "tabKey": 4,
      "image": "assets/images/position/armed50.png",
      "title": 'Menarmed 1 Sthira Yudha',
      "isActive": false,
    },
    {
      "tabKey": 5,
      "image": "assets/images/position/armed50.png",
      "title": 'Yonarmed 9 Pasopati',
      "isActive": false,
    },
  ];

  @override
  void initState() {
    onSetTab(0);
    super.initState();
  }

  void getPosition() async {
    await PositionRepo.instance.show({}).then((value) {
      _statusLoadPosition = true;
      _positionList = value;
      setState(() {});
    });
  }

  // void onSearch(String searchValue) {
  //   if (_navigation == 1) {
  //     _positionList = _kostradList
  //         .where((value) =>
  //             value['nama']!
  //                 .toLowerCase()
  //                 .contains(searchValue.toLowerCase()) ||
  //             value['jabatan']!
  //                 .toLowerCase()
  //                 .contains(searchValue.toLowerCase()))
  //         .toList();
  //   } else if (_navigation == 2) {
  //     _positionList = _armedList
  //         .where((value) =>
  //             value['nama']!
  //                 .toLowerCase()
  //                 .contains(searchValue.toLowerCase()) ||
  //             value['jabatan']!
  //                 .toLowerCase()
  //                 .contains(searchValue.toLowerCase()))
  //         .toList();
  //   }
  //   setState(() {});
  // }

  void onSetTab(int index) {
    _currentTab = _tabData[index];
    getPosition({satuan: _currentTab['']});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FieldSearch(
          onChange: ((value) {}),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 70,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            children: _tabData.asMap().entries.map((item) {
              return GestureDetector(
                onTap: (() => onSetTab(item.key)),
                child: Container(
                  constraints: const BoxConstraints(minWidth: 100),
                  height: double.infinity,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: item.value['isActive'] ? Colors.red[50] : bgWhite,
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
                      Image.asset(item.value['image'], width: 30, height: 30,),
                      Text(
                        item.value['title'].toString(),
                        style: TextStyle(fontWeight: FontWeight.bold, color: item.value['isActive'] ? Colors.redAccent : Colors.black,),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(
          height: 10,
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
                            "title": "Pejabat ${_currentTab['title'].toString()}",
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
