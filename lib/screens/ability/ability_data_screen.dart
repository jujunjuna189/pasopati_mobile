import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/users_repo.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/widgets/shimmer/shimmer_widget.dart';
import 'package:pro_mobile/widgets/text_field/field_search.dart';

class AbilityDataScreen extends StatefulWidget {
  const AbilityDataScreen({Key? key}) : super(key: key);

  @override
  State<AbilityDataScreen> createState() => _AbilityDataScreenState();
}

class _AbilityDataScreenState extends State<AbilityDataScreen> {
  List _userList = [];
  List _personnelList = [];

  @override
  void initState() {
    super.initState();
    getPersonnel();
  }

  void getPersonnel() async {
    await UsersRepo.instance.show({
      "role": jsonEncode([3])
    }).then((value) {
      _userList = value;
      setPersonnel();
    });
    setState(() {});
  }

  void setPersonnel() {
    _personnelList = _userList;
  }

  void onSearch(String searchValue) {
    _personnelList = _userList
        .where((value) =>
            value['name']!.toLowerCase().contains(searchValue.toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Data Kemampuan"),
      ),
      body: Column(
        children: [
          FieldSearch(
            onChange: ((value) {
              onSearch(value);
            }),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: _personnelList.isEmpty
                ? buildPersonnelListShimmer()
                : buildPersonnelList(),
          ),
        ],
      ),
    );
  }

  Widget buildPersonnelListShimmer() {
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

  Widget buildPersonnelList() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: _personnelList.isNotEmpty
          ? _personnelList.map((value) {
              return ClipRRect(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: GestureDetector(
                    onTap: (() {
                      Navigator.of(context).pushNamed("/ability",
                          arguments: jsonEncode({"user_id": value['id']}));
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
                                  value['name'] ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(value['pangkat'] ?? '...'),
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
