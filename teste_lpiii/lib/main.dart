import 'package:aplicacao_lpiii/commons/mypicked_image.dart';
import 'package:aplicacao_lpiii/models/users/users.dart';
import 'package:aplicacao_lpiii/pages/authentication/login_page.dart';
//import 'package:aplicacao_lpiii/pages/horario/eventos.dart';
// import 'package:aplicacao_lpiii/pages/horario/eventos.dart';
import 'package:aplicacao_lpiii/pages/horario/horario_page.dart';
import 'package:aplicacao_lpiii/pages/main/main_page.dart';
import 'package:aplicacao_lpiii/pages/materias/materia_page.dart';
import 'package:aplicacao_lpiii/pages/userprofile/user_profile_edit_page.dart';
import 'package:aplicacao_lpiii/pages/userprofile/user_profile_page.dart';
//import 'package:aplicacao_lpiii/services/horario/evento_services.dart';
import 'package:aplicacao_lpiii/services/users/users_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
//import 'dart:collection';

//import 'package:table_calendar/table_calendar.dart';


void main() async {
  await initializeDateFormatting('pt_BR');
  WidgetsFlutterBinding.ensureInitialized();
  
  var options = const FirebaseOptions(
    apiKey: "AIzaSyBN-Aj-B0pSGtuhO9L7pSEBjpNFyAe2O3U", // chave de API Web
    authDomain: "apliclpiii.firebaseapp.com", // templates em autenticação
    projectId: "apliclpiii", //codigo do projeto
    storageBucket: "apliclpiii.appspot.com", //link do storage
    messagingSenderId: "947544463764", //numero do projeto
    appId: "1:947544463764:android:556ed082e91155eee49781", // id do aplicativo
  );
  if (kIsWeb) {
    await Firebase.initializeApp(options: options);
  } else {
    await Firebase.initializeApp();
  }
/* runApp(
    const MyApp(),
    
  );*/
  initializeDateFormatting('pt_BR').then((_) => runApp(MyApp()));

}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersServices>(
          create: (_) => UsersServices(),
          lazy: false,
        ),
        ChangeNotifierProvider<MyPickedImage>(
          create: (context) => MyPickedImage(),
        ),
        
       
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorSchemeSeed: Color.fromARGB(255, 180, 232, 245),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/mainpage': (context) => MainPage(),
          '/userprofile': (context) => const UserProfilePage(),
          '/userprofileedit': (context) => const UserProfileEditPage(),
          '/materia': (context) => MateriaListView(),
          '/horario': (context) => HorarioPage()
        },
        onGenerateRoute: (settings){
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginPage());
            case '/mainpage':
              return MaterialPageRoute(builder: (_) => MainPage());
            case '/userprofile':
              return MaterialPageRoute(builder: (_) => UserProfilePage());
            case '/userprofileedit':
              return MaterialPageRoute(
                  builder: (_) =>
                      UserProfileEditPage(users: settings.arguments as Users));
            case '/materia':
              return MaterialPageRoute(builder: (_) => MateriaListView());
            case '/horario':
              return MaterialPageRoute(builder: (_) => HorarioPage());
          }
          debugPrint("");
        },
      ),
    );
  }
}