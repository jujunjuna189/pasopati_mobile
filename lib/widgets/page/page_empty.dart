import 'package:flutter/material.dart';

class PageEmpty extends StatelessWidget {
  const PageEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/illustration/no_data.png", scale: 5,),
          const Text("Belum ada data", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black26),),
        ],
      ),
    );
  }
}
