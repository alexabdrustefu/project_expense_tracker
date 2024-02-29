import 'package:flutter/material.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}
//classe privata
class _ExpensesState extends State<Expenses>{
  @override
  Widget build(BuildContext context) {
    //scaffold fornisce una struttura base del progetto
    return const Scaffold(
      //aggiungo un Widget column
      body: Column(
        children: [
          Text('Grafici'),
          Text('expanses data')

        ],
      ),
    );
  }
}