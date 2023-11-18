/*import 'package:aplicacao_lpiii/pages/materias/materia_page.dart';
import 'package:aplicacao_lpiii/services/materia/materia_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HorarioPage extends StatelessWidget {
  const HorarioPage({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    var items = context.watch<MateriaService>().items;
    var cart = context.watch<MateriaService>().cart;
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: ListView(
        children: items
            .map(
              (e) => ListTile(
                title: Text(e.name ?? ''),
                subtitle: Text("USD " + (e.price ?? '')),
                trailing: IconButton(
                  icon: Icon(
                    cart.contains(e) ? Icons.remove_circle : Icons.add_circle,
                  ),
                  onPressed: () {
                    if (!cart.contains(e))
                      context.read<MateriaService>().addToCart(e);
                    else
                      context.read<MateriaService>().removeFromCart(e);
                  },
                ),
              ),
            )
            .toList(),
      ),
      floatingActionButton: cart.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Materia(),
                  ),
                );
              },
              label: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 156, 132, 187),
                    ),
                    child: Text(cart.length.toString()),
                  ),
                  SizedBox(width: 8),
                  Text('Cart'),
                ],
              ),
            ),
    );
  }
}*/

import 'package:aplicacao_lpiii/controller/horario/horario_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HorarioPage extends GetView<HorarioController> {
  HorarioPage({Key? key}) : super(key: key);
  final control = Get.put(HorarioController());
  DateTime? _selectDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildHorario(),
    );
  }

  Widget _buildHorario() {
    return GetBuilder<HorarioController>(
        id: 'calendario',
        builder: (context) {
          return Column(
            children: [
              Container(
                child: TableCalendar(
                  firstDay: control.primeiroDia,
                  lastDay: control.ultimoDia,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectDay, day),
                  onDaySelected: _onDaySelect,
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                  ),
                  onFormatChanged: (format) => {
                    if (_calendarFormat != format) {setState(() {})}
                  },
                  /* firstDay: control.primeiroDia,
                  lastDay: control.ultimoDia,
                  focusedDay: control.diaAtual,
                  selectedDayPredicate: (day) => isSameDay(_selectDay, day),
                  onDaySelected: (diaInicio, diaFim) async {
                    control.getProgramaDia(diaInicio);
                  },
                  locale: control.locale,

                  // Formatação do estilo do mês/ano
                  headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      titleTextStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 30, 30, 31),
                      ),
                      titleTextFormatter: (day, locale) =>
                          DateFormat('MMMM yyyy', locale)
                              .format(day)
                              .capitalize!),

                  //formatação dia semana
                  daysOfWeekStyle: DaysOfWeekStyle(
                      dowTextFormatter: (day, locale) =>
                          DateFormat.E(control.locale)
                              .format(day)[0]
                              .toUpperCase()),

                  // formatação
                  calendarStyle: CalendarStyle(
                      defaultTextStyle: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      weekendTextStyle: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      todayDecoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight:
                              isSameDay(DateTime.now(), control.diaAtual)
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                          fontSize: isSameDay(DateTime.now(), control.diaAtual)
                              ? 16
                              : 14),
                      selectedDecoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.purple)),*/
                ),
              ),
              Flexible(child: _builAgenda(control.diaAtual))
            ],
          );
        });
  }

  Widget _builAgenda(DateTime data) {
    return GetBuilder<HorarioController>(
        id: 'agenda',
        builder: (context) {
          return control.agenda.isEmpty
              ? Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      const Text(
                        "teste",
                        style: const TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(6),
                  child: Column(children: [
                    Flexible(
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          backgroundColor: Colors.amber,
                          child: Text(
                            data.day.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: ListView.builder(
                        itemCount: control.agenda.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                control.agenda[index],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
                );
        });
  }
}
