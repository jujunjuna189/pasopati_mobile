import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/auth_repo.dart';
import 'package:pro_mobile/repository/suggestion_repo.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/widgets/button/button_submit.dart';
import 'package:pro_mobile/widgets/text_field/field_area.dart';
import 'package:pro_mobile/widgets/text_field/field_text.dart';
import 'package:pro_mobile/widgets/toast/toast_loader.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({Key? key}) : super(key: key);

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  Map<String, dynamic> _user = {};
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    await AuthRepo.instance.getSession("user").then((value) {
      setState(() {
        _user = value;
      });
    });
  }

  void onSend() async {
    ToastLoader.instance.showLoader();
    Map<String, dynamic> dataBatch = {
      'from_id': _user['id'] != null ? _user['id'].toString() : '-',
      'from_display': _user['name'] != null ? _user['name'].toString() : '-',
      'message': _messageController.text,
    };
    await SuggestionRepo.instance.store(dataBatch).then((value) {
      if (value) {
        clearForm();
      }
    });
  }

  void clearForm() {
    _messageController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Saran dan Masukan"),
      ),
      body: ListView(
        physics: const ScrollPhysics(),
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: BoxDecoration(
                color: bgWhite,
                border: Border.all(width: 1, color: bgLightPrimary),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Saran dan Masukan",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FieldArea(
                    controller: _messageController,
                    padding: 8,
                    placeHolder: "Masukan Saran...",
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ButtonSubmit(
                      onPressed: (() {
                        onSend();
                      }),
                      text: "Kirim"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
