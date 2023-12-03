import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Eventos {
   
  String? id;
  String? description;
  DateTime? date;
  String? userId;
  bool? public;
  String? title;
  //String? email;
  Eventos(
      {this.id,
      this.description,
      this.date,
      this.userId,
      this.public,
      this.title,
     // this.email
     });

  Eventos copyWith({
    String? id,
    String? description,
    DateTime? date,
    String? userId,
    bool? public,
    String? title,
    //String? email,
  }) {
    return Eventos(
      id: id ?? this.id,
      description: description ?? this.description,
      date: date ?? this.date,
      userId: userId ?? this.userId,
      public: public ?? this.public,
      title: title ?? this.title,
      //email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    debugPrint('toMap $date!');
    return {
      'id': id,
      'description': description,
      // 'date': date!.millisecondsSinceEpoch,
      'userId': userId,
      'public': public,
      'title': title,
      'date': date != null ? Timestamp.fromDate(date!) : null,

      //'date': date,
      //'email': email,
    };
  }

  //método construtor para salvar os dados do documento firebase
  Eventos.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    description = doc.get('description');
    date = (doc.get('date') as Timestamp).toDate();
    userId = doc.get('userId');
    public = doc.get('public');
    title = doc.get('title');
    //email = doc.get('email');
  }

  Eventos.fromSnapshot(DocumentSnapshot doc)
      : id = doc.id,
        description = doc.get('description'),
        date = (doc.get('date') as Timestamp).toDate(),
        userId = doc.get('userId'),
        public = doc.get('public'),
        title = doc.get('title');
        //email = doc.get('email');

  factory Eventos.fromMap(Map<String, dynamic> map) {
    return Eventos(
      id: map['id'],
      description: map['description'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      userId: map['userId'],
      public: map['public'],
      title: map['title'],
      //email: map['email'],
    );
  }
  factory Eventos.fromDS(String id, Map<String, dynamic> data) {
    return Eventos(
      id: id,
      description: data['description'],
      date: DateTime.fromMillisecondsSinceEpoch(data['date']),
      userId: data['user_id'],
      public: data['public'],
      title: data['title'],
      //email: data['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Eventos.fromJson(String source) =>
      Eventos.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Evento(id: $id, title: $title, description: $description, date: $date, userId: $userId, public: $public)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Eventos &&
        o.id == id &&
        o.title == title &&
        o.description == description &&
        o.date == date &&
        o.userId == userId &&
        o.public == public ;
        //o.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        date.hashCode ^
        userId.hashCode ^
        public.hashCode ;
        //email.hashCode;
  }
}
