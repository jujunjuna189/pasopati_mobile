import 'package:flutter/cupertino.dart';

class BackgroundScafold extends StatelessWidget {
  const BackgroundScafold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/bg/bg.png",
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }
}
