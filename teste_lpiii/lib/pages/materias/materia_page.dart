
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class MateriaListView extends StatefulWidget {
//   @override
//   _MateriaListViewState createState() => _MateriaListViewState();
// }

// class _MateriaListViewState extends State<MateriaListView> {
//   List<String> items = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Materia(as)'),
//       ),
//       body: Container(
//         height: 200.0,
        
//         child: ListView.builder(
//           itemCount: items.length,
          
//           itemBuilder: (context, index) {
//             return Card(
//               elevation: 2.0,
//               margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              
//               child: ListTile(
//                 title: Text(items[index]),
//                 onTap: () {
//                   _showSnackbar(context, items[index]);
//                 },
//               ),
              
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showDialog(context);
//         },
//         tooltip: 'Adicionar à Lista',
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   void _showSnackbar(BuildContext context, String item) {
//     final snackbar = SnackBar(
//       content: Text('Você selecionou: $item'),
//       duration: Duration(seconds: 1),
//     );

//     ScaffoldMessenger.of(context).showSnackBar(snackbar);
//   }

//   void _showDialog(BuildContext context) async {
//     TextEditingController textController = TextEditingController();

//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Adicionar à Lista'),
//           content: Container(
//             height: 80.0, // Ajuste a altura conforme necessário
//             child: Column(
//               children: [
//                 TextField(
//                   controller: textController,
//                   decoration: InputDecoration(
//                     labelText: 'Texto do Item',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 16.0),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancelar'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 String text = textController.text;

//                 if (text.isNotEmpty) {
//                   setState(() {
//                     items.add(text);
//                   });
//                   Navigator.pop(context);
//                 }
//               },
//               child: Text('Adicionar'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

/*
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package for formatting date and time

class MateriaListView extends StatefulWidget {
  @override
  _MateriaListViewState createState() => _MateriaListViewState();
}

class _MateriaListViewState extends State<MateriaListView> {
  List<Map<String, dynamic>> items = []; // Use a map to store text, date, and time

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Materia(as)'),
      ),
      body: Container(
        height: 200.0,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            String text = items[index]['text'];
            String dateTime = items[index]['dateTime'];

            return Card(
              elevation: 2.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                title: Text(text),
                subtitle: Text(dateTime), // Display date and time as subtitle
                onTap: () {
                  _showSnackbar(context, text);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        tooltip: 'Adicionar à Lista',
        child: Icon(Icons.add),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String item) {
    final snackbar = SnackBar(
      content: Text('Você selecionou: $item'),
      duration: Duration(seconds: 1),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void _showDialog(BuildContext context) async {
    TextEditingController textController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar à Lista'),
          content: Container(
            height: 120.0, // Adjust the height as necessary
            child: Column(
              children: [
                TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    labelText: 'Texto do Item',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Text('Data e Hora:'),
                    SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () async {
                        DateTime? selectedDateTime = await _selectDateTime(context);
                        if (selectedDateTime != null) {
                          String formattedDateTime =
                              DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime);
                          textController.text = '$formattedDateTime';
                        }
                      },
                      child: Text('Selecionar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                String text = textController.text;

                if (text.isNotEmpty) {
                  setState(() {
                    items.add({'text': text, 'dateTime': text});
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  Future<DateTime?> _selectDateTime(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class MateriaListView extends StatefulWidget {
  @override
  _MateriaListViewState createState() => _MateriaListViewState();
   
}

class _MateriaListViewState extends State<MateriaListView> {
  List<Map<String, dynamic>> items = [];
 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Materia(as)'),
      ),
      body: Container(
        height: 200.0,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            String text = items[index]['text'];
            DateTime dateTime = items[index]['dateTime'];

            // Formatar a data e a hora usando o pacote intl
            String formattedDateTime = DateFormat('EEEE HH:mm').format(dateTime);

            return Card(
              elevation: 2.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Texto: $text',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Data e Hora: $formattedDateTime',
                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        tooltip: 'Adicionar à Lista',
        child: Icon(Icons.add),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String item) {
    final snackbar = SnackBar(
      content: Text('Você selecionou: $item'),
      duration: Duration(seconds: 1),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void _showDialog(BuildContext context) async {
    TextEditingController textController = TextEditingController();
    DateTime selectedDateTime = DateTime.now();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar à Lista'),
          content: Container(
            height: 180.0, // Ajuste a altura conforme necessário
            child: Column(
              children: [
                TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    labelText: 'Texto do Item',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                   DateTime? selectedDateTime = await _selectDateTime(context);
                    if (selectedDateTime != null) {
                      textController.text = selectedDateTime.toIso8601String();
                    }
                  },
                  child: Text('Selecionar Data e Hora'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                String text = textController.text;

                if (text.isNotEmpty) {
                  setState(() {
                    items.add({'text': text, 'dateTime': selectedDateTime});
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  Future<DateTime?> _selectDateTime(BuildContext context) async {
   
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),

    );
  }
}