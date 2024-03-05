import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_expense_tracker/models/expense.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense, {super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    //utilizzo widget che genera delle card
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start ,
          children: [
            Text(expense.title, style: Theme.of(context).textTheme.titleLarge,),
            const SizedBox(
              height: 4,
            ),
             Row(
              children: [
                //formatta un numero in una stringa es: 1.2342 => 1.23
                  Text('€${expense.prezzo.toStringAsFixed(2)}'),
                //fa si che il widget prenda tutto lo spazio a disposizione
                const Spacer(),
                Row(
                  children: [
                     Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    //richiamo il metodo
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
