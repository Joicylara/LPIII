import 'package:aplicacao_lpiii/services/users/users_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Materia extends StatefulWidget {
  Materia();

  @override
  _MateriaState createState() => _MateriaState();
}

class _MateriaState extends State<Materia> {
  final TextEditingController _nameMateria = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //var cart = context.watch<CartService>().cart;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Consumer<UsersServices>(
          builder: (context, usersServices, child) {
            return Column(
              children: [
                const Text(
                  "Matéria(s) do Usuário",
                  style: TextStyle(
                    color: Color.fromARGB(255, 8, 8, 8),
                    fontSize: 28,
                    fontFamily: 'Lustria',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Card(
                  elevation: 1.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 15,
                    ),
                    child: Row(children: [
                      /*ClipOval(
                        child: Image.network(
                          
                          usersServices.users!.image!,
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const CircularProgressIndicator(
                              backgroundColor: Color.fromARGB(255, 221, 171, 213),
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 244, 54, 197)),
                            );
                          },
                         
                          
                        ),
                      ),*/
                      const SizedBox(
                        width: 15,
                      ),
                      TextFormField(
                        controller: _nameMateria,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            label: Text("Nome da matéria"),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.3),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1.5))),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ]),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/userprofileedit'),
                  child: const Card(
                    elevation: 1.0,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person_add_alt_1_outlined,
                            size: 90.0,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cadastro',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Edite dados pessoais, profissionais'),
                                Text(
                                    'Emails, telefones, redes sociais e outros'),
                              ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
