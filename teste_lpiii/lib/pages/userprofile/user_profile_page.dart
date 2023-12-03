import 'package:aplicacao_lpiii/services/users/users_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Edição do Perfil de Usuário'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Consumer<UsersServices>(
          builder: (context, usersServices, child) {
            return Column(
              children: [
                const Text(
                  "Perfil de Usuário",
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
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 244, 54, 197)),
                            );
                          },
                         
                          
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                          'Nome: ${usersServices.users!.userName!.toUpperCase()}'),
                          Text('Email: ${usersServices.users!.email}'),
                          Text('Telefone: ${usersServices.users!.phone}'),
                          Text('Data de nascimento: ${usersServices.users!.birthday}'),
                          Text('Redes sociais: ${usersServices.users!.socialMedia}')
                        ],
                      )
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
