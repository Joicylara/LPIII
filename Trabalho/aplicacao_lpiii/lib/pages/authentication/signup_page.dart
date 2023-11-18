import 'dart:io';

import 'package:aplicacao_lpiii/commons/custom_textformfield.dart';
import 'package:aplicacao_lpiii/commons/mypicked_image.dart';
import 'package:aplicacao_lpiii/models/users/users.dart';
import 'package:aplicacao_lpiii/services/users/users_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _birthday = TextEditingController();
  final TextEditingController _socialMedia = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 45,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Image.asset(
                  'assets/images/logoo.png',//pedir ajuda para o Samu
                  height: 100,
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Registre-se",
                      style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(255, 184, 13, 161),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Text(
                      'aplicativo organizador acadêmico',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 184, 13, 161),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Consumer<MyPickedImage>(
                  builder: (context, myPickedImage, child) {
                    if (myPickedImage.pickImage == null ||
                        myPickedImage.webImage!.isEmpty) {
                      return dottedBorder(color: Color.fromARGB(255, 184, 13, 161));
                    } else {
                      return GestureDetector(
                        onTap: () {
                          Provider.of<MyPickedImage>(context, listen: false)
                              .myPickedImage();
                        },
                        child: ClipOval(
                          child: kIsWeb
                              ? Image.memory(
                                  myPickedImage.webImage!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  myPickedImage.pickImage!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      );
                    }
                  },
                )
              ]),
              const SizedBox(
                height: 25.0,
              ),
              TextFormField(
                controller: _userName,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    label: Text("Nome do usuário"),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.3),
                    ),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 1.5))),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    label: Text("E-mail"),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.3),
                    ),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 1.5))),
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextFormField(
                enabled: true,
                labelText: const Text('Telefone'),
                controller: _phone,
                prefixIcon: Icons.phone_enabled,
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextFormField(
                enabled: true,
                labelText: const Text('Data de Nascimento'),
                controller: _birthday,
                prefixIcon: Icons.calendar_month,
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomTextFormField(
                enabled: true,
                labelText: const Text('Rede Social'),
                controller: _socialMedia,
                prefixIcon: Icons.calendar_month,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                obscureText: true,
                controller: _password,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.fingerprint),
                    label: Text("Senha"),
                    suffixIcon: Icon(Icons.remove_red_eye),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.3),
                    ),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 1.5))),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(top: 8.0),
                child: const Text(
                  'Esqueceu a senha?',
                  style: TextStyle(
                    color: Color.fromARGB(255, 184, 13, 161),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Consumer<MyPickedImage>(
                    builder: (context, myPickedImage, child) {
                      return ElevatedButton(
                        onPressed: () async {
                          UsersServices _usersServices = UsersServices();
                          Users users = Users();
                          users.email = _email.text;
                          users.userName = _userName.text;
                          users.password = _password.text;
                          users.birthday = _birthday.text;
                          users.socialMedia = _socialMedia.text;
                          users.phone = _phone.text;

                          if (await _usersServices.signUp(
                              users,
                              kIsWeb
                                  ? myPickedImage.webImage
                                  : myPickedImage.pickImage,
                              kIsWeb)) {
                            if (context.mounted) Navigator.of(context).pop();
                          } else {
                            if (context.mounted) {
                              var snackBar = const SnackBar(
                                content:
                                    Text('Algum erro aconteceu no registro'),
                                backgroundColor:
                                    Color.fromARGB(255, 161, 71, 66),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(50),
                                elevation: 20,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 1.5,
                            minimumSize: const Size.fromHeight(50),
                            shape: LinearBorder.bottom()),
                        child: const Text(
                          'Registrar',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Ou',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          height: 50,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          "Login com Google",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Já tem uma conta?'),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 184, 13, 161),
                            fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dottedBorder({Color? color}) {
    return DottedBorder(
        dashPattern: const [5],
        color: color!,
        child: Column(
          children: [
            IconButton(
              iconSize: 80,
              icon: const Icon(Icons.image_search_rounded),
              onPressed: () {
                Provider.of<MyPickedImage>(context, listen: false)
                    .myPickedImage();
              },
            ),
            Text(
              "Foto",
              style: TextStyle(color: color),
            )
          ],
        ));
  }
}
