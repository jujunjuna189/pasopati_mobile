import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pro_mobile/utils/api.dart';
import 'package:pro_mobile/widgets/toast/toast_loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleViewScreen extends StatefulWidget {
  const ArticleViewScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  final String data;

  @override
  State<ArticleViewScreen> createState() => _ArticleViewScreenState();
}

class _ArticleViewScreenState extends State<ArticleViewScreen> {
  String _apiArticleView = '${Api.artikelView}?artikel_id=';

  @override
  void initState() {
    super.initState();
    ToastLoader.instance.showLoader();
    setUrlArticle();
  }

  void setUrlArticle() {
    _apiArticleView += jsonDecode(widget.data)['article_id'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: _apiArticleView,
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: ((finished) {
        ToastLoader.instance.hideLoader();
      }),
    );
  }
}
