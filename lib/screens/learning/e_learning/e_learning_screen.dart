import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/e_learning_repo.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/widgets/shimmer/shimmer_widget.dart';

class ELearningScreen extends StatefulWidget {
  const ELearningScreen({Key? key}) : super(key: key);

  @override
  State<ELearningScreen> createState() => _ELearningScreenState();
}

class _ELearningScreenState extends State<ELearningScreen>
    with AutomaticKeepAliveClientMixin {
  List _eLearning = [];

  @override
  void initState() {
    getELearning();
    super.initState();
  }

  void getELearning() async {
    await ELearningRepo.instance.show({}).then((value) {
      _eLearning = value;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: _eLearning.isEmpty ? buildELearningShimmer() : buildELearning(),
    );
  }

  Widget buildELearningShimmer() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 5,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ShimmerWidget.circular(
                  height: 16,
                  width: 150,
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            const ShimmerWidget.rectangular(height: 100),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }

  Widget buildELearning() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: _eLearning.isNotEmpty
          ? _eLearning.map((value) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: (() {
                          Navigator.of(context).pushNamed("/e_learning_view",
                              arguments: jsonEncode({'path': value['path']}));
                        }),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Menarmed Mobile",
                                  style: TextStyle(fontSize: 10),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.circle,
                                  size: 3,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "E-Learning",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              value["judul"] ?? '...',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      !['', null].contains(value["deskripsi"]) &&
                              value["deskripsi"].toString().length > 400
                          ? "${value["deskripsi"].toString().substring(0, 400)}..."
                          : value["deskripsi"] ?? '...',
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black45),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
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
                  "Tidak ada artikel",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
