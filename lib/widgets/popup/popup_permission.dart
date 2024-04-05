import 'package:flutter/material.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/widgets/button/button_submit.dart';
import 'package:pro_mobile/widgets/text_field/field_text.dart';

class PopupPermission {
  PopupPermission._privateConstructor();
  static final PopupPermission instance = PopupPermission._privateConstructor();

  void showPopup(BuildContext context, {String data = "", Function? callback}) {
    TextEditingController destinationController = TextEditingController();
    TextEditingController typeVihicleController = TextEditingController();
    showDialog(
        barrierDismissible: false,
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      decoration: BoxDecoration(
                        color: bgWhite,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: bgLightPrimary, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Tujuan",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FieldText(
                              controller: destinationController,
                              placeHolder: "..."),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Jenis Kendaraan",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FieldText(
                              controller: typeVihicleController,
                              placeHolder: "..."),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: ButtonSubmit(
                              text: "Simpan",
                              onPressed: (() {
                                callback!({
                                  'destination': destinationController.text,
                                  'type_vihicle': typeVihicleController.text
                                });
                                Navigator.of(context).pop();
                              }),
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
