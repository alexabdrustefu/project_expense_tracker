import 'package:uuid/uuid.dart';

//genera id univoci
const  uuid=  Uuid();

class Expense {
  //costruttore
   Expense(
      {
      required this.title,
      required this.prezzo,
      required this.data}) : id= uuid.v4();
      //con uuid.v4 assegno id univoci alla stringa id
  //definisco proprietá
  final String id;
  final String title;
  final double prezzo;
  final DateTime data;
}
