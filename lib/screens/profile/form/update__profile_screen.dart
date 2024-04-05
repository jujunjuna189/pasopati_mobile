import 'package:flutter/material.dart';
import 'package:pro_mobile/repository/auth_repo.dart';
import 'package:pro_mobile/repository/profile_repo.dart';
import 'package:pro_mobile/utils/colors.dart';
import 'package:pro_mobile/widgets/text_field/field_date.dart';
import 'package:pro_mobile/widgets/text_field/field_text.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pangkatController = TextEditingController();
  final TextEditingController _korpController = TextEditingController();
  final TextEditingController _satuanController = TextEditingController();
  final TextEditingController _tempatLahirController = TextEditingController();
  final TextEditingController _tglLahirController = TextEditingController();
  final TextEditingController _agamaController = TextEditingController();
  final TextEditingController _golDarahController = TextEditingController();
  final TextEditingController _sumberPaController = TextEditingController();
  final TextEditingController _jabatanController = TextEditingController();
  final TextEditingController _senjataController = TextEditingController();
  Map<String, dynamic> _user = {};

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    await AuthRepo.instance.getSession("user").then((value) {
      setState(() {
        _user = value;
        setForm();
      });
    });
  }

  void setForm() {
    _nameController.text = _user["name"] ?? '';
    _pangkatController.text = _user["pangkat"] ?? '';
    _korpController.text = _user["korp"] ?? '';
    _satuanController.text = _user["satuan"] ?? '';
    _tempatLahirController.text = _user["tempat_lahir"] ?? '';
    _tglLahirController.text = _user["tgl_lahir"] ?? '';
    _agamaController.text = _user["agama"] ?? '';
    _golDarahController.text = _user["gol_darah"] ?? '';
    _sumberPaController.text = _user["sumber_pa"] ?? '';
    _jabatanController.text = _user["jabatan"] ?? '';
    _senjataController.text = _user["senjata"] ?? '';
  }

  Map<String, dynamic> getFormData() {
    Map<String, dynamic> dataBatch = {
      "user_id": _user['id'].toString(),
      "name": _nameController.text,
      "pangkat": _pangkatController.text,
      "korp": _korpController.text,
      "satuan": _satuanController.text,
      "tempat_lahir": _tempatLahirController.text,
      "tgl_lahir": _tglLahirController.text,
      "agama": _agamaController.text,
      "gol_darah": _golDarahController.text,
      "sumber_pa": _sumberPaController.text,
      "jabatan": _jabatanController.text,
      "senjata": _senjataController.text,
    };
    return dataBatch;
  }

  void onUpdate() async {
    Map<String, dynamic> dataBatch = getFormData();
    await ProfileRepo.instance.store(dataBatch);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Ubah Profile"),
            GestureDetector(
              onTap: (() {
                onUpdate();
              }),
              child: const Icon(Icons.check),
            ),
          ],
        ),
      ),
      body: ListView(
        physics: const ScrollPhysics(),
        children: [
          const SizedBox(
            height: 50,
          ),
          Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: bgLightPrimary,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      _user['name'] == null
                          ? ''
                          : _user['name']
                              .toString()
                              .substring(0, 2)
                              .toUpperCase(),
                      style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.width / 20),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: bgWhite,
                    border: Border.all(width: 1, color: bgLightPrimary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FieldText(
                    controller: _nameController,
                    placeHolder: "Nama Lengkap ...",
                    border: false,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: bgWhite,
                    border: Border.all(width: 1, color: bgLightPrimary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FieldText(
                      controller: _pangkatController,
                      placeHolder: "Pangkat ...",
                      border: false),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: bgWhite,
                    border: Border.all(width: 1, color: bgLightPrimary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FieldText(
                      controller: _korpController,
                      placeHolder: "Korp ...",
                      border: false),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: bgWhite,
                    border: Border.all(width: 1, color: bgLightPrimary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FieldText(
                      controller: _satuanController,
                      placeHolder: "Satuan ...",
                      border: false),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: bgWhite,
                    border: Border.all(width: 1, color: bgLightPrimary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FieldText(
                      controller: _tempatLahirController,
                      placeHolder: "Tempat Lahir...",
                      border: false),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: bgWhite,
                    border: Border.all(width: 1, color: bgLightPrimary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FieldDate(
                      controller: _tglLahirController,
                      placeHolder: "Tanggal Lahir...",
                      border: false),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: bgWhite,
                    border: Border.all(width: 1, color: bgLightPrimary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FieldText(
                      controller: _agamaController,
                      placeHolder: "Agama ...",
                      border: false),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: bgWhite,
                    border: Border.all(width: 1, color: bgLightPrimary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FieldText(
                      controller: _golDarahController,
                      placeHolder: "Golongan Darah ...",
                      border: false),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: bgWhite,
                    border: Border.all(width: 1, color: bgLightPrimary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FieldText(
                      controller: _sumberPaController,
                      placeHolder: "Sumber Pa ...",
                      border: false),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: bgWhite,
                    border: Border.all(width: 1, color: bgLightPrimary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FieldText(
                      controller: _jabatanController,
                      placeHolder: "Jabatan ...",
                      border: false),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: bgWhite,
                    border: Border.all(width: 1, color: bgLightPrimary),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FieldText(
                      controller: _senjataController,
                      placeHolder: "Senjata ...",
                      border: false),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
