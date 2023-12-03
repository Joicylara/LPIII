import 'package:aplicacao_lpiii/models/users/users.dart';
import 'package:aplicacao_lpiii/pages/horario/eventos.dart';
import 'package:aplicacao_lpiii/services/users/users_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/*class EventServices {
  //instância para persistência dos dados no Firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Eventos? appEvent;
  Users? users;
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('events');
  DocumentReference get _firestoreRef =>
      _firestore.doc('events/${appEvent!.id}');

  final DateFormat formatter = DateFormat('dd/MM/yyyy');

 
  Future<void> addEventTime(DateTime date, Eventos events) async {
    debugPrint('CRUD - $date');
    await _firestore.collection('events').add(events.toMap());
  }


  Future<void> addEventTimeObject(DateTime date, Eventos events) async {
    debugPrint('CRUD - $date');
    await _firestore.collection('events').add({
      'userId': '1234',
      'date': date, //DateFormat('MM/dd/yyyy').format(date),
      'title': events.title,
      'description': events.description,
      'public': events.public,
    });
  }

  Stream<QuerySnapshot> getEventTime(String userId) {
    return _firestore
        .collection('events')
        .where('userId', isEqualTo: userId)
        .orderBy('date')
        .snapshots();
  }

  Future<Eventos?> getEventsById(String? id) async {
    final docProduct = _firestore.collection('events').doc(id);
    final snapShot = await docProduct.get();
    if (snapShot.exists) {
      return Eventos.fromDocument(snapShot);
    } else {
      return null;
    }
  }

  Stream<QuerySnapshot> getAllEvents() {
    return _collectionRef.snapshots();
  }

  Future<List<Eventos>> getEvents(String userId) async {
    List<Eventos> listEvents = [];
    final result = await _collectionRef.get();
    listEvents = result.docs.map((e) => Eventos.fromSnapshot(e)).toList();
    return listEvents;
  }

  Future<List?> getCalendarEvents(String? userId) async {
    List<dynamic>? eventList;

    try {
      final _calendarEvent =
          await _firestore.collection('events').doc(userId).get();
      eventList = _calendarEvent.data()!["calendarEvents"];
    } catch (e) {
      print(e);
    }

    return eventList;
  }
}*/

//import 'package:aplicacao_lpiii/models/users/users.dart';
//import 'package:aplicacao_lpiii/pages/horario/eventos.dart';
//import 'package:aplicacao_lpiii/services/users/users_services.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/foundation.dart';
//import 'package:intl/intl.dart';

/*class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
    
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}*/

class EventServices {
  //instância para persistência dos dados no Firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Eventos? appEvent;
  Users? users;
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('events');
  DocumentReference get _firestoreRef =>
      _firestore.doc('events/${appEvent!.id}');

  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  

Future<void> addEventTime(DateTime date, Eventos events) async {
    debugPrint('CRUD - $date');
    await _firestore.collection('events').add(events.toMap());
  }
 
 /*Future<void> addEventTimeObject(DateTime date, Eventos events) async {
  final currentUser = await _auth.currentUser;
  debugPrint('CRUD - $date');
  await _firestore.collection('events').add({
    'userId': currentUser?.uid,
    'date': date,
    'title': events.title,
    'description': events.description,
    'public': events.public,
  });
  }*/
  Future<void> addEventTimeObject(DateTime date, Eventos events) async {
  final currentUser = await _auth.currentUser;
  debugPrint('CRUD - $date');
  await _firestore.collection('events').add({
    'id': currentUser?.email,
    'userId': currentUser?.uid,
    'date': date,
    'title': events.title,
    'description': events.description,
    'public': events.public,
  });
}

 

  Stream<QuerySnapshot> getEventTime(String userId) {
    return _firestore
        .collection('events')
        .where('userId', isEqualTo: userId)
        .orderBy('date')
        .snapshots();
  }

  Future<Eventos?> getEventsById(String? id) async {
    final docProduct = _firestore.collection('events').doc(id);
    final snapShot = await docProduct.get();
    if (snapShot.exists) {
      return Eventos.fromDocument(snapShot);
    } else {
      return null;
    }
  }

  Stream<QuerySnapshot> getAllEvents() {
    return _collectionRef.snapshots();
  }

  Future<List<Eventos>> getEvents(String userId) async {
    List<Eventos> listEvents = [];
    final result = await _collectionRef.get();
    listEvents = result.docs.map((e) => Eventos.fromSnapshot(e)).toList();
    return listEvents;
  }
Future<List?> getCalendarEvents(String? userId) async {
  List<dynamic>? eventList;

  try {
    final querySnapshot = await _firestore
        .collection('events')
        .where('userId', isEqualTo: userId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      eventList = querySnapshot.docs.first.data()["calendarEvents"];
    }
  } catch (e) {
    print(e);
  }

  return eventList;
}
}

