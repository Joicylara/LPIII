import 'package:aplicacao_lpiii/models/users/users.dart';
import 'package:aplicacao_lpiii/services/users/users_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileEditPage extends StatelessWidget {
  const UserProfileEditPage({this.users, super.key});
  final Users? users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Consumer<UsersServices>(
          builder: (context, usersServices, child) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Editando Perfil de Usuário",
                  style: TextStyle(
                    color: Color.fromARGB(255, 8, 8, 8),
                    fontSize: 28,
                    fontFamily: 'Lustria',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ClipOval(
                  child: Image.network(
                    usersServices.users!.image!,
                    height: 90,
                    width: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const CircularProgressIndicator(
                        backgroundColor: Color.fromARGB(255, 221, 171, 213),
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 244, 54, 197)),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Nome do Usuário'),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Telefone'),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Rede Social'),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Data de Nascimento'),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
