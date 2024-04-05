import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_mobile/model/ket_presence_model.dart';
import 'package:pro_mobile/utils/colors.dart';

class PopupPresence {
  PopupPresence._privateConstructor();
  static final PopupPresence instance = PopupPresence._privateConstructor();

  final List<Map<String, dynamic>> _ketList =
      KetPresenceModel.instance.ketList();

  void showPopup(BuildContext context, {String data = "", Function? callback}) {
    showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          // for detect position object
          return StatefulBuilder(builder: (context, setState) {
            return Stack(
              children: [
                Positioned(
                  left: 15,
                  right: 15,
                  top: MediaQuery.of(context).size.height / 5,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: bgWhite,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: bgLightPrimary, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 20),
                            child: Text(
                              "Keterangan",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 300,
                            child: ListView(
                              padding: const EdgeInsets.only(bottom: 20),
                              physics: const BouncingScrollPhysics(),
                              children: _ketList
                                  .asMap()
                                  .map((i, value) {
                                    return MapEntry(
                                      i,
                                      ClipRRect(
                                        child: GestureDetector(
                                          onTap: (() {
                                            callback!(value);
                                            Navigator.of(context).pop();
                                          }),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 15),
                                            decoration: BoxDecoration(
                                              border: i != (_ketList.length - 1)
                                                  ? const Border(
                                                      bottom: BorderSide(
                                                          width: 1,
                                                          color:
                                                              bgLightPrimary))
                                                  : null,
                                            ),
                                            child: Center(
                                                child: Text(
                                              value['ket'],
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            )),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                                  .values
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          });
        });
  }
}
