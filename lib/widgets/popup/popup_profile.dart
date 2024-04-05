import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/auth_repo.dart';
import 'package:pro_mobile/utils/colors.dart';

class PopupProfile {
  PopupProfile._privateConstructor();
  static final PopupProfile instance = PopupProfile._privateConstructor();

  void showPopup(BuildContext context, {String data = "", Function? callback}) {
    showDialog(
        barrierColor: Colors.transparent,
        barrierDismissible: true,
        context: context,
        builder: (context) {
          // for detect position object
          return StatefulBuilder(builder: (context, setState) {
            return Stack(
              alignment: Alignment.topRight,
              children: [
                Positioned(
                  right: 15,
                  top: MediaQuery.of(context).size.height / 13,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: 200,
                      decoration: BoxDecoration(
                        color: bgWhite,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: bgLightPrimary, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Setting",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: (() {
                              Navigator.of(context).pushNamed("/profile");
                            }),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              child: Row(
                                children: const [
                                  Icon(Icons.person),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Profile",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            height: 20,
                            thickness: 0.5,
                            endIndent: 0,
                            color: Colors.black,
                          ),
                          GestureDetector(
                            onTap: (() {
                              AuthRepo.instance.logout();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/login", (Route<dynamic> route) => false);
                            }),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              child: Row(
                                children: const [
                                  Icon(Icons.logout),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Logout",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
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
