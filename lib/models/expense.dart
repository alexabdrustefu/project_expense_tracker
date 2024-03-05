import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
//ymd= yyyy/mm/gg
final formatter=DateFormat.yMd();

//genera id univoci
const uuid = Uuid();

//defninisco la classe enum
enum Category { food, travel, leisure, work }

//definisco una mappa per assegnare le icone
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  //costruttore
  Expense(
      {required this.title,
      required this.prezzo,
      required this.data,
      required this.category})
      : id = uuid.v4();
  //con uuid.v4 assegno id univoci alla stringa id
  //definisco proprietá
  final String id;
  final String title;
  final double prezzo;
  final DateTime data;
  //permette di definire le categorie
  final Category category;
//creo metodo per la formattazione delle date
  String get formattedDate {
    return formatter.format(data);
  }
}
