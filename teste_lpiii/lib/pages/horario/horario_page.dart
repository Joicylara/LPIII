
/*import 'package:aplicacao_lpiii/pages/horario/eventos.dart';
import 'package:aplicacao_lpiii/services/horario/evento_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';




class HorarioPage extends StatefulWidget {
  @override
  _HorarioEventoState createState() => _HorarioEventoState();
}

class _HorarioEventoState extends State<HorarioPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectDay;
  EventServices eventService = EventServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<DateTime, List<Eventos>> eventos = {};
  final TextEditingController _eventoController = TextEditingController();
  late final ValueNotifier<List<Eventos>> _selectEventos;
  final TextEditingController _descricaoController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _selectDay = _focusedDay;
    _selectEventos = ValueNotifier(_getEventosDoDia(_selectDay!));
  }

  void _onDaySelect(DateTime selectDay, DateTime focusedDay) {
    if (!isSameDay(_selectDay, selectDay)) {
      setState(() {
        _selectDay = selectDay;
        _focusedDay = focusedDay;
        _selectEventos.value = _getEventosDoDia(_focusedDay);
      });
    }
  }

  List<Eventos> _getEventosDoDia(DateTime dia) {
    return eventos[dia] ?? [];
  }

  @override
  void dispose() {
    _eventoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Horário', 
        ),
      
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                scrollable: true,
                title: Text('Adicionar Evento'),
                content: Column(
                  children: [
                    TextField(
                      controller: _eventoController,
                      decoration: InputDecoration(labelText: 'Título do evento'),
                    ),
                    TextField(
                      controller: _descricaoController,
                      decoration: InputDecoration(labelText: 'Descrição do evento'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String title = _eventoController.text;
                      String description = _descricaoController.text;
                      final currentUser = await _auth.currentUser;

                      await eventService.addEventTimeObject(
                        DateTime.now(),
                        Eventos( 
                          title: title,
                          description: description,
                          public: true,
                          date: _selectDay!,
                          userId: currentUser?.uid, // Substitua com a forma correta de obter o userId do usuário logado
                          email: currentUser?.email,
                        ),
                      );

                      if (title.isNotEmpty) {
                        setState(() {
                          eventos.update(
                            _selectDay!,
                            (value) {
                             /* value.add(
                                Eventos(
                                  title: title,
                                  description: description,
                                  public: true,
                                ),
                              );*/
                              value.add(
  Eventos(
    title: title,
    description: description,
    date: _selectDay!,
    userId: currentUser?.uid, // Substitua com a forma correta de obter o userId do usuário logado
    email: currentUser?.email,
    public: true,
  ),
);

                              return value;
                            },
                            ifAbsent: () => [
                              Eventos(
                                id: currentUser?.email,
                                title: title,
                                description: description,
                                public: true,
                                date: _selectDay!,
                                userId: currentUser?.uid, // Substitua com a forma correta de obter o userId do usuário logado
                                email: currentUser?.email,
                              ),
                            ],
                          );
                        });
                        _selectEventos.value = _getEventosDoDia(_selectDay!);
                      }

                      Navigator.pop(context);
                      _eventoController.clear();
                      _descricaoController.clear();
                    },
                    child: Text('Ok'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 191, 237, 240),
      ),

      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 01),
            lastDay: DateTime.utc(2050, 1, 01),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectDay, day),
            calendarFormat: _calendarFormat,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: _onDaySelect,
            eventLoader: (day) => _getEventosDoDia(day),
            calendarStyle: CalendarStyle(
              defaultTextStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              weekendTextStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              todayDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 142, 186, 223),
              ),
              selectedTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: isSameDay(DateTime.now(), _selectDay)
                    ? FontWeight.normal
                    : FontWeight.bold,
                fontSize: isSameDay(DateTime.now(), _selectDay) ? 16 : 14,
              ),
              selectedDecoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 224, 176, 233)),
            ),
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: ValueListenableBuilder<List<Eventos>>(
              valueListenable: _selectEventos,
              builder: (context, value, _) {
                return ListView.builder(
  itemCount: value.length,
  itemBuilder: (context, index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: () {
          // Lida com o toque no item da lista, se necessário
        },
        title: Text('Title: ${value[index].title}'),
        subtitle: Text('Description: ${value[index].description}\nEmail: ${value[index].email}\nDate: ${value[index].date}\npublico: ${value[index].public}\nUserID: ${value[index].userId}'),
      ),
    );
  },
);
/*ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        onTap: () {
                          // Lida com o toque no item da lista, se necessário
                        },
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );*/
              },
            ),
          ),
        ],
      ),
    );
  }
}*/



/*import 'package:aplicacao_lpiii/pages/horario/eventos.dart';
import 'package:aplicacao_lpiii/services/horario/evento_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // Importa o pacote intl para formatação de data
import 'package:table_calendar/table_calendar.dart';

class HorarioPage extends StatefulWidget {
  @override
  _HorarioEventoState createState() => _HorarioEventoState();
}

class _HorarioEventoState extends State<HorarioPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectDay;
  EventServices eventService = EventServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<DateTime, List<Eventos>> eventos = {};
  final TextEditingController _eventoController = TextEditingController();
  late final ValueNotifier<List<Eventos>> _selectEventos;
  final TextEditingController _descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectDay = _focusedDay;
    _selectEventos = ValueNotifier(_getEventosDoDia(_selectDay!));
  }

  void _onDaySelect(DateTime selectDay, DateTime focusedDay) {
    if (!isSameDay(_selectDay, selectDay)) {
      setState(() {
        _selectDay = selectDay;
        _focusedDay = focusedDay;
        _selectEventos.value = _getEventosDoDia(_focusedDay);
      });
    }
  }

  List<Eventos> _getEventosDoDia(DateTime dia) {
    return eventos[dia] ?? [];
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Horário',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                scrollable: true,
                title: Text('Adicionar Evento'),
                content: Column(
                  children: [
                    TextField(
                      controller: _eventoController,
                      decoration: InputDecoration(labelText: 'Título do evento'),
                    ),
                    TextField(
                      controller: _descricaoController,
                      decoration: InputDecoration(labelText: 'Descrição do evento'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String title = _eventoController.text;
                      String description = _descricaoController.text;
                      final currentUser = await _auth.currentUser;

                      /*await eventService.addEventTimeObject(
                        DateTime.now(),
                        Eventos(
                          title: title,
                          description: description,
                          public: true,
                          date: _selectDay!,
                          userId: currentUser?.uid,
                          email: currentUser?.email,
                        ),
                      );*/
                      await eventService.addEventTimeObject(
  DateTime.now(),
  Eventos(
    title: title,
    description: description,
    public: true,
    //date: _selectDay ?? DateTime.now(), // Usando ?? para fornecer um valor padrão se _selectDay for nulo
    date: DateTime(
      _selectDay!.year,
      _selectDay!.month,
      _selectDay!.day,
      DateTime.now().hour,
      DateTime.now().minute,
    ),
    userId: currentUser?.uid,
   
  ),
);


                      if (title.isNotEmpty) {
                        setState(() {
                          eventos.update(
                            _selectDay!,
                            (value) {
                              value.add(
                                Eventos(
                                  title: title,
                                  description: description,
                                  //date: _selectDay?? DateTime.now(),
                                  date: DateTime(
      _selectDay!.year,
      _selectDay!.month,
      _selectDay!.day,
      DateTime.now().hour,
      DateTime.now().minute,
    ),
                                  userId: currentUser?.uid,
                                
                                  public: true,
                                ),
                              );
                              return value;
                            },
                            ifAbsent: () => [
                              Eventos(
                                id: currentUser?.email,
                                title: title,
                                description: description,
                                public: true,
                               // date: _selectDay ?? DateTime.now(),
                               date: DateTime(
      _selectDay!.year,
      _selectDay!.month,
      _selectDay!.day,
      DateTime.now().hour,
      DateTime.now().minute,
    ),
                                userId: currentUser?.uid,
                                
                              ),
                            ],
                          );
                        });
                        _selectEventos.value = _getEventosDoDia(_selectDay!);
                      }

                      Navigator.pop(context);
                      _eventoController.clear();
                      _descricaoController.clear();
                    },
                    child: Text('Ok'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 191, 237, 240),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 01),
            lastDay: DateTime.utc(2050, 1, 01),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectDay, day),
            calendarFormat: _calendarFormat,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: _onDaySelect,
            eventLoader: (day) => _getEventosDoDia(day),
            calendarStyle: CalendarStyle(
              defaultTextStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              weekendTextStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              todayDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 142, 186, 223),
              ),
              selectedTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: isSameDay(DateTime.now(), _selectDay)
                    ? FontWeight.normal
                    : FontWeight.bold,
                fontSize: isSameDay(DateTime.now(), _selectDay) ? 16 : 14,
              ),
              selectedDecoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 224, 176, 233)),
            ),
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: ValueListenableBuilder<List<Eventos>>(
              valueListenable: _selectEventos,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        onTap: () {
                          // Lida com o toque no item da lista, se necessário
                        },
                        title: Text('Title: ${value[index].title}'),
                        subtitle: Text(
                          'Description: ${value[index].description}\n'
                          //'Email: ${value[index].email}\n'
                          'Date: ${(value[index].date)}\n'
                          'Publico: ${value[index].public}\n'
                          'ID: ${value[index].id}\n'
                          'UserID: ${value[index].userId}',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}*/

/*import 'dart:convert';
import 'package:aplicacao_lpiii/pages/horario/eventos.dart';
import 'package:aplicacao_lpiii/services/horario/evento_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class HorarioPage extends StatefulWidget {
  @override
  _HorarioEventoState createState() => _HorarioEventoState();
}

class _HorarioEventoState extends State<HorarioPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectDay;
  EventServices eventService = EventServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, List<Eventos>> eventos = {};
  final TextEditingController _eventoController = TextEditingController();
  late final ValueNotifier<List<Eventos>> _selectEventos;
  final TextEditingController _descricaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectDay = _focusedDay;
    _selectEventos = ValueNotifier(_getEventosDoDia(_selectDay!));
    _loadEventos();
  }

  @override
  void dispose() {
    _eventoController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _onDaySelect(DateTime selectDay, DateTime focusedDay) {
    if (!isSameDay(_selectDay, selectDay)) {
      setState(() {
        _selectDay = selectDay;
        _focusedDay = focusedDay;
        _selectEventos.value = _getEventosDoDia(_focusedDay);
      });
    }
  }

  List<Eventos> _getEventosDoDia(DateTime dia) {
    return eventos[formatDateTime(dia)] ?? [];
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  DateTime parseDateTime(String formattedDateTime) {
    return DateFormat('yyyy-MM-dd').parse(formattedDateTime);
  }

  Future<void> _saveEventos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'eventos',
      jsonEncode(eventos.map((key, value) => MapEntry(
            key,
            value.map((evento) => evento.toJson()).toList(),
          ))),
    );
  }

  Future<void> _loadEventos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? eventosString = prefs.getString('eventos');

    if (eventosString != null) {
      Map<String, dynamic> eventosMap = jsonDecode(eventosString);

      setState(() {
        eventos = eventosMap.map((key, value) => MapEntry(
              key,
              (value as List<dynamic>)
                  .map((evento) => Eventos.fromJson(evento))
                  .toList(),
            ));
        _selectEventos.value = _getEventosDoDia(_selectDay!);
      });
    }
  }

  /*@override
  void dispose() {
    _eventoController.dispose();
    _saveEventos(); // Salvar eventos ao fechar o widget
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Horário',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                scrollable: true,
                title: Text('Adicionar Evento'),
                content: Column(
                  children: [
                    TextField(
                      controller: _eventoController,
                      decoration: InputDecoration(labelText: 'Título do evento'),
                    ),
                    TextField(
                      controller: _descricaoController,
                      decoration: InputDecoration(labelText: 'Descrição do evento'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String title = _eventoController.text;
                      String description = _descricaoController.text;
                      final currentUser = await _auth.currentUser;

                      await eventService.addEventTimeObject(
                        DateTime.now(),
                        Eventos(
                          title: title,
                          description: description,
                          public: true,
                          date: _selectDay!,
                          userId: currentUser?.uid,
                         // email: currentUser?.email,
                        ),
                      );

                      if (title.isNotEmpty) {
                        setState(() {
                          eventos.update(
                            formatDateTime(_selectDay!),
                            (value) {
                              value.add(
                                Eventos(
                                  title: title,
                                  description: description,
                                  date: _selectDay!,
                                  userId: currentUser?.uid,
                                 // email: currentUser?.email,
                                  public: true,
                                ),
                              );
                              return value;
                            },
                            ifAbsent: () => [
                              Eventos(
                                id: currentUser?.email,
                                title: title,
                                description: description,
                                public: true,
                                date: _selectDay!,
                                userId: currentUser?.uid,
                                //email: currentUser?.email,
                              ),
                            ],
                          );
                        });
                        _selectEventos.value = _getEventosDoDia(_selectDay!);
                        _saveEventos(); // Salvar eventos após adicionar um novo
                      }

                      Navigator.pop(context);
                      _eventoController.clear();
                      _descricaoController.clear();
                    },
                    child: Text('Ok'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 191, 237, 240),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 01),
            lastDay: DateTime.utc(2050, 1, 01),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectDay, day),
            calendarFormat: _calendarFormat,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: _onDaySelect,
            eventLoader: (day) => _getEventosDoDia(day),
            calendarStyle: CalendarStyle(
              defaultTextStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              weekendTextStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              todayDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 142, 186, 223),
              ),
              selectedTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: isSameDay(DateTime.now(), _selectDay)
                    ? FontWeight.normal
                    : FontWeight.bold,
                fontSize: isSameDay(DateTime.now(), _selectDay) ? 16 : 14,
              ),
              selectedDecoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 224, 176, 233)),
            ),
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: ValueListenableBuilder<List<Eventos>>(
              valueListenable: _selectEventos,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        onTap: () {
                          // Lida com o toque no item da lista, se necessário
                        },
                        title: Text('Title: ${value[index].title}'),
                        subtitle: Text(
                          'Description: ${value[index].description}\n'
                          'Date: ${(value[index].date)}\n'
                          'Publico: ${value[index].public}\n'
                          'ID: ${value[index].id}\n'
                          'UserID: ${value[index].userId}',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}*/


import 'dart:collection';

import 'package:aplicacao_lpiii/pages/horario/eventos.dart';
import 'package:aplicacao_lpiii/services/horario/evento_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HorarioPage extends StatefulWidget {
  const HorarioPage({super.key});

  @override
  HorarioPageState createState() => HorarioPageState();
}

class HorarioPageState extends State<HorarioPage> {
  final todaysDate = DateTime.now();
  var _focusedCalendarDate = DateTime.now();
  final _initialCalendarDate = DateTime(2000);
  final _lastCalendarDate = DateTime(2050);
  DateTime? selectedCalendarDate;
  CalendarFormat format = CalendarFormat.month;
  final DateFormat formatter = DateFormat('dd/MM/yyyy - HH:mm:ss');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final titleController = TextEditingController();
  final descpController = TextEditingController();
  bool load = false;
  List<Eventos> events = [];

  late Map<DateTime, List<Eventos>> mySelectedEvents;

  LinkedHashMap<DateTime, List<Eventos>>? _groupedEvents;

  EventServices eventServices = EventServices();

  @override
  void initState() {
    super.initState();
    selectedCalendarDate = _focusedCalendarDate;
    _groupedEvents = LinkedHashMap(equals: isSameDay, hashCode: getHashCode);
    mySelectedEvents = {};
    getSchedules();
  }

  @override
  void dispose() {
    titleController.dispose();
    descpController.dispose();
    super.dispose();
  }

  Future getSchedules() async {
    final currentUser = await _auth.currentUser;
    String? idUsuario = currentUser?.uid;
    await eventServices.getEvents(idUsuario!).then((schedules) {
      events.clear();
      for (var i = 0; i < schedules.length; i++) {
        events.add(Eventos(
            id: schedules[i].id,
            userId: currentUser?.uid,
            public: true,
            title: schedules[i].title,
            date: schedules[i].date,
            description: schedules[i].description));
      }
      setState(() {
        load = true;
      });
    });
    _groupEvents(events);
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  _groupEvents(List<Eventos> events) {
    _groupedEvents = LinkedHashMap(equals: isSameDay, hashCode: getHashCode);
    for (var event in events) {
      DateTime date = DateTime.utc(
        event.date!.year,
        event.date!.month,
        event.date!.day,
        event.date!.hour,
        event.date!.minute,
        event.date!.second,
      );
      if (_groupedEvents![date] == null) _groupedEvents![date] = [];
      _groupedEvents![date]!.add(event);
    }
  }

  List<Eventos> _listOfDayEvents(DateTime? dateTime) {
    return mySelectedEvents[dateTime!] ?? [];
  }

  List<dynamic> _getEventsForDay(DateTime? date) {
    return _groupedEvents?[date!] ?? [];
  }

  _showAddEventDialog(DateTime? day) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Novo Evento -  ${formatter.format(day!)}'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTextField(
                controller: titleController, hint: 'Título do Evento'),
            const SizedBox(
              height: 20.0,
            ),
            buildTextField(
                controller: descpController, hint: 'Descrição do evento'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
  if (titleController.text.isEmpty ||
      descpController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Por favor, informe o título e a descrição do evento'),
        duration: Duration(seconds: 3),
      ),
    );
    return;
  } else {
    final currentUser = await _auth.currentUser;
    setState(() {
      Eventos appEvent = Eventos();
      appEvent.userId = currentUser?.uid;
      // Correção na conversão da data para UTC
      appEvent.date = _focusedCalendarDate.toUtc();
      appEvent.description = descpController.text;
      appEvent.title = titleController.text;
      appEvent.public = true;

      if (mySelectedEvents[day] != null) {
        mySelectedEvents[day]?.add(appEvent);
        eventServices.addEventTime(day, appEvent);
      } else {
        mySelectedEvents[day] = [appEvent];
        eventServices.addEventTime(day, appEvent);
      }
    });

    titleController.clear();
    descpController.clear();

    Navigator.pop(context);
    return;
  }
},

            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
      {String? hint, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: hint ?? '',
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 160, 200, 233), width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 160, 200, 233), width: 1.5),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Calendário - Dia Selecionado ${formatter.format(selectedCalendarDate!).toString()}'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventDialog(selectedCalendarDate),
        label: const Text('Adicionar Evento'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 5.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                side: BorderSide(
                    color: Color.fromARGB(255, 160, 200, 233), width: 2.0),
              ),
              child: TableCalendar(
                onFormatChanged: (CalendarFormat cf) {
                  setState(() {
                    format = cf;
                  });
                },
                availableCalendarFormats: const {
                  CalendarFormat.month: 'mês',
                  CalendarFormat.week: 'semana',
                  CalendarFormat.twoWeeks: '2 semanas'
                },
                locale: 'pt_BR',
                focusedDay: _focusedCalendarDate,
                firstDay: _initialCalendarDate,
                lastDay: _lastCalendarDate,
                calendarFormat: format,
                weekendDays: const [DateTime.sunday, 6],
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekHeight: 40.0,
                rowHeight: 60.0,
                eventLoader: _getEventsForDay,
                headerStyle: const HeaderStyle(
                  titleTextStyle: TextStyle(
                      color: Color.fromARGB(255, 13, 13, 14), fontSize: 20.0),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 160, 200, 233),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  formatButtonTextStyle: TextStyle(
                      color: Color.fromARGB(255, 8, 8, 8), fontSize: 16.0),
                  formatButtonDecoration: BoxDecoration(
                    color: Color.fromARGB(255, 61, 155, 233),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Color.fromARGB(255, 12, 12, 12),
                    size: 28,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Color.fromARGB(255, 8, 8, 8),size: 28,
                  ),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                    color: Color.fromARGB(255, 3, 3, 3),
                  ),
                ),
                calendarStyle: const CalendarStyle(
                  weekendTextStyle: TextStyle(
                    color: Color.fromARGB(255, 10, 10, 10),
                  ),
                  todayDecoration: BoxDecoration(
                    color: Color.fromARGB(255, 210, 111, 228),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Color.fromARGB(255, 238, 131, 167),
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                      color: Color.fromARGB(255, 86, 7, 110),
                      shape: BoxShape.circle),
                ),
                selectedDayPredicate: (day) =>
                    isSameDay(day, selectedCalendarDate),
                onDaySelected: (selectedDay, focusedDay) {
                  debugPrint('dia selecionado ${selectedDay.toString()}');
                  if (!isSameDay(selectedCalendarDate, selectedDay)) {
                    setState(() {
                      selectedCalendarDate = selectedDay;
                      _focusedCalendarDate = focusedDay;
                    });
                  }
                  debugPrint(
                      'dia atribuido ${selectedCalendarDate.toString()}');
                  debugPrint(
                      'dia em foco ${_focusedCalendarDate.toString()}');
                },
              ),
            ),
            ..._getEventsForDay(selectedCalendarDate).map(
              (event) => ListTile(
                leading: const Icon(
                  Icons.done,
                  color: Color.fromARGB(255, 160, 200, 233),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                      'id: ${event.id} - Título do Evento:   ${event.title}'),
                ),
                subtitle: Text(
                    'Descrição:   ${event.description} -  ${formatter.format(event.date!.toLocal())}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
