/*import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class HorarioController extends GetxController {
  late DateTime primeiroDia;
  late DateTime ultimoDia;
  late DateTime diaAtual;

  //conteúdo da agenda no dia selecionado
  List<String> agenda = [];

  //formatação do calendario
  CalendarFormat calendarFormat = CalendarFormat.month;

  //tratar a tradução de texto
  String locale = 'pt-BR';

  @override
  void onInit() async {
    //parametros iniciais
    primeiroDia = DateTime.now().add(Duration(days: -365));
    ultimoDia = DateTime.now().add(Duration(days: 365));
    diaAtual = DateTime.now();

    //agenda do dia atual
    getProgramaDia(diaAtual);

    super.onInit();
  }

  //busca a agenda do dia
  Future getProgramaDia(data) async {
    diaAtual = data;

    //busca dados da agenda
    // getAgenda(data);

    update(['calendario', 'agenda']);
  }

  //Map<DateTime, List<Eventos>> eventos = {};
  /*void getAgenda(DateTime data) {
    agenda.clear();

    if (data.day == 27) {
      agenda = [
        '09:30 : Ciências do ambiente',
        '13:00 : LPIII',
        '16:20: Fenômenos de transporte'
      ];
    } else if (data.day == 28) {
      agenda = [
        '10:00 : Projeto Integrador',
        '15:20 : Sinais e Sistemais lineares',
        '00:00: aniversário da Helo'
      ];
    }
  }*/
}*/
