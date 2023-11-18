import 'package:aplicacao_lpiii/commons/mypicked_image.dart';
import 'package:aplicacao_lpiii/models/users/users.dart';
import 'package:aplicacao_lpiii/pages/authentication/login_page.dart';
import 'package:aplicacao_lpiii/pages/horario/horario_page.dart';
import 'package:aplicacao_lpiii/pages/main/main_page.dart';
import 'package:aplicacao_lpiii/pages/materias/materia_page.dart';
import 'package:aplicacao_lpiii/pages/userprofile/user_profile_edit_page.dart';
import 'package:aplicacao_lpiii/pages/userprofile/user_profile_page.dart';
import 'package:aplicacao_lpiii/services/users/users_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

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
  runApp(
    const MyApp(),
  );
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
        )
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
          '/materia': (context) => Materia(),
          '/horario': (context) => HorarioPage()
        },
        onGenerateRoute: (settings) {
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
              return MaterialPageRoute(builder: (_) => Materia());
            case '/horario':
              return MaterialPageRoute(builder: (_) => HorarioPage());
          }
        },
      ),
    );
  }
}




// // // main.dart
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'dart:io';
// // import 'package:image_picker/image_picker.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return const MaterialApp(
// //       // Hide the debug banner
// //       debugShowCheckedModeBanner: false,
// //       title: 'albertosales.com',
// //       home: HomePage(),
// //     );
// //   }
// // }

// // class HomePage extends StatefulWidget {
// //   const HomePage({Key? key}) : super(key: key);

// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   // This is the file that will be used to store the image
// //   File? _image;
// //   Uint8List webImage = Uint8List(8);
// //   // This is the image picker
// //   final _picker = ImagePicker();
// //   // Implementing the image picker
// //   Future<void> _openImagePicker() async {
// //     if (!kIsWeb) {
// //       final XFile? pickedImage =
// //           await _picker.pickImage(source: ImageSource.gallery);
// //       if (pickedImage != null) {
// //         setState(() {
// //           _image = File(pickedImage.path);
// //         });
// //       }
// //     } else if (kIsWeb) {
// //       XFile? image = await _picker.pickImage(source: ImageSource.gallery);
// //       if (image != null) {
// //         var imageSelected =
// //             await image.readAsBytes(); //converte a imagem para bytes
// //         setState(() {
// //           webImage = imageSelected;
// //           _image = File('a');
// //         });
// //       }
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         appBar: AppBar(
// //           title: const Text('albertosales.com'),
// //         ),
// //         body: SafeArea(
// //           child: Padding(
// //             padding: const EdgeInsets.all(35),
// //             child: Column(children: [
// //               Center(
// //                 // this button is used to open the image picker
// //                 child: ElevatedButton(
// //                   onPressed: _openImagePicker,
// //                   child: const Text('Selecione uma Imagem'),
// //                 ),
// //               ),
// //               const SizedBox(height: 35),
// //               // The picked image will be displayed here
// //               Container(
// //                 alignment: Alignment.center,
// //                 width: double.infinity,
// //                 height: 300,
// //                 color: Colors.grey[300],
// //                 child: ClipOval(
// //                   // borderRadius: BorderRadius.circular(12),
// //                   child: kIsWeb
// //                       ? Image.memory(
// //                           webImage,
// //                           height: 80,
// //                           width: 80,
// //                           fit: BoxFit.cover,
// //                         )
// //                       : Image.file(
// //                           _image!,
// //                           height: 80,
// //                           width: 80,
// //                           fit: BoxFit.cover,
// //                         ),
// //                 ),
// //               )
// //             ]),
// //           ),
// //         ));
// //   }
// // }
