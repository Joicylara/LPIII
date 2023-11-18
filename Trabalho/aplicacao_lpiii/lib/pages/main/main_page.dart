import 'package:aplicacao_lpiii/pages/horario/eventos.dart';
import 'package:aplicacao_lpiii/pages/horario/horario_page.dart';
import 'package:aplicacao_lpiii/pages/materias/materia_page.dart';
import 'package:aplicacao_lpiii/pages/userprofile/user_profile_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;
  Map<DateTime, List<Eventos>> eventos = {};
  TextEditingController _eventosController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: ,
        elevation: 2.0,

        title: const Text(
          "Organizador Acadêmico",
          style: TextStyle(
            color: Color.fromARGB(255, 22, 22, 22),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text("Compromisso"),
                  content: Padding(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      controller: _eventosController,
                    ),
                  ),
                  actions: [
                    ElevatedButton(onPressed: () {
                      eventos.addAll()
                      Navigator.of(context).pop();
                    }, child: Text("Salvar"))
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
      body: [
        HorarioPage(),
        Materia(),
        Center(
          child: Container(
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Boletim'),
              ],
            ),
          ),
        ),
        const UserProfilePage(),
      ][_index],
      bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (int position) {
            setState(() {
              _index = position;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.access_time),
              label: 'Horário',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book),
              label: 'Matéria(s)',
            ),
            NavigationDestination(
              icon: Icon(Icons.feed_outlined),
              label: 'Boletim',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_box_outlined),
              label: 'Perfil de Usuário',
            )
          ]),
    );
  }
}
