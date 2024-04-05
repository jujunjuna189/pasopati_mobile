import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pro_mobile/widgets/toast/toast_loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ELearningViewScreen extends StatefulWidget {
  const ELearningViewScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  final String data;

  @override
  State<ELearningViewScreen> createState() => _ELearningViewScreenState();
}

class _ELearningViewScreenState extends State<ELearningViewScreen> {
  String _apiELearningView = '';

  @override
  void initState() {
    super.initState();
    ToastLoader.instance.showLoader();
    setUrlELearninge();
  }

  void setUrlELearninge() {
    _apiELearningView += jsonDecode(widget.data)['path'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: _apiELearningView,
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: ((finished) {
        ToastLoader.instance.hideLoader();
      }),
    );
  }
}
