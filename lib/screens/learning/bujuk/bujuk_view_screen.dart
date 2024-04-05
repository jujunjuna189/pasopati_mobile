import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pro_mobile/widgets/toast/toast_loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BujukViewScreen extends StatefulWidget {
  const BujukViewScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  final String data;

  @override
  State<BujukViewScreen> createState() => _BujukViewScreenState();
}

class _BujukViewScreenState extends State<BujukViewScreen> {
  String _apiBujukView = '';

  @override
  void initState() {
    super.initState();
    ToastLoader.instance.showLoader();
    setUrlELearninge();
  }

  void setUrlELearninge() {
    _apiBujukView += jsonDecode(widget.data)['path'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: _apiBujukView,
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: ((finished) {
        ToastLoader.instance.hideLoader();
      }),
    );
  }
}
