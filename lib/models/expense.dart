import 'package:uuid/uuid.dart';

//genera id univoci
const  uuid=  Uuid();
//defninisco la classe enum
enum Category{food, travel, leisure, work}

class Expense {
  //costruttore
   Expense(
      {
      required this.title,
      required this.prezzo,
      required this.data,
      required this.category}) : id= uuid.v4();
      //con uuid.v4 assegno id univoci alla stringa id
  //definisco proprietá
  final String id;
  final String title;
  final double prezzo;
  final DateTime data;
  //permette di definire le icone
  final Category category;


}
