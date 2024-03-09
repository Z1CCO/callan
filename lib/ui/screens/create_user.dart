import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreateUser extends StatefulWidget {
  const CreateUser({
    super.key,
  });

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? selectedValue;

  final List<String> items = [
    'Ingliz tili',
    'Rus tili',
    'Arab tili',
    'Flutter',
    'Xattotlik',
    'Access',
    'Web daturlash',
  ];
  void onSubmit() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      FocusScope.of(context).unfocus();
      form.save();
      SnackBar snackBar = SnackBar(
        content: Text('xush kelibsiz $username'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Timer(
        const Duration(seconds: 2),
        () {
          ScaffoldMessenger.of(context).clearSnackBars();
          Navigator.pop(context, username);
          Navigator.pop(context, username);
        },
      );
    }
  }

  String? validateForm(String? text) {
    if (text == null) return 'Ism yarating';
    if (text.trim().length < 3 || text.isEmpty) {
      return 'Ism juda qisqa';
    } else if (text.trim().length > 12) {
      return 'Ism juda uzun';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        toolbarHeight: 75.0,
        backgroundColor: Colors.blue.shade400,
        automaticallyImplyLeading: false,
        title: const Text(
          'Profil yaratish',
          style: TextStyle(color: Colors.white, fontSize: 28.0),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              const Text(
                'Ism kiritish',
                style: TextStyle(fontSize: 25),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0).copyWith(bottom: 10),
                child: SizedBox(
                  height: 55,
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validateForm,
                      onSaved: (value) => setState(() => username = value),
                      decoration: const InputDecoration(
                        labelText: 'Ism yozing',
                        labelStyle:
                            TextStyle(fontSize: 16, color: Colors.black),
                        hintText: "Eng kamida 3 ta harf dan iborat bo'lsin",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(18, 0, 16, 18),
                width: 375.0,
                height: 50.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: const Text(
                      'Yo\'nalish Tanlash',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    items: items
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 40,
                      width: 140,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all(6),
                        thumbVisibility: MaterialStateProperty.all(true),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18.0),
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  onPressed: onSubmit,
                  child: const Text(
                    'Yuborish',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
