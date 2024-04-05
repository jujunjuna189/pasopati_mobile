import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/article_repo.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/widgets/shimmer/shimmer_widget.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen>
    with AutomaticKeepAliveClientMixin {
  List _article = [];

  @override
  void initState() {
    getArticle();
    super.initState();
  }

  void getArticle() async {
    await ArticleRepo.instance.show({}).then((value) {
      _article = value;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: _article.isEmpty ? buildArticleShimmer() : buildArticle(),
    );
  }

  Widget buildArticleShimmer() {
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

  Widget buildArticle() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: _article.isNotEmpty
          ? _article.map((value) {
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
                          Navigator.of(context).pushNamed("/article_view",
                              arguments:
                                  jsonEncode({'article_id': value['id']}));
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
                                  "Artikel",
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
