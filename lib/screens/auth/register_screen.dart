import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/auth_repo.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/widgets/button/button_submit.dart';
import 'package:pro_mobile/widgets/text_field/field_password.dart';
import 'package:pro_mobile/widgets/text_field/field_text.dart';
import 'package:pro_mobile/widgets/toast/toast_loader.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void onRegister() async {
    ToastLoader.instance.showLoader();
    Map<String, dynamic> dataBatch = {
      'name': _nameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
    };

    await AuthRepo.instance.register(dataBatch).then((value) {
      if (value) {
        clearForm();
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/home", (Route<dynamic> route) => false);
      }
    });
  }

  void clearForm() {
    _nameController.text = '';
    _emailController.text = '';
    _passwordController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const ScrollPhysics(),
        children: [
          const SizedBox(
            height: 50,
          ),
          const Center(
              child: Text(
            "Daftar Akun",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )),
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
                    "Nama",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FieldText(
                    controller: _nameController,
                    placeHolder: "Masukan Nama Lengkap...",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Nrp",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FieldText(
                    controller: _emailController,
                    placeHolder: "Masukan Nrp...",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  FieldPassword(
                    controller: _passwordController,
                    placeHolder: "Masukan Password...",
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ButtonSubmit(
                      onPressed: (() {
                        onRegister();
                      }),
                      text: "Daftar"),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: (() {
                        Navigator.of(context).pushNamed("/login");
                      }),
                      child: const Center(
                          child: Text(
                        "Login !",
                        style: TextStyle(fontSize: 16),
                      ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
