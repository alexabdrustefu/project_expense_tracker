import 'package:flutter/material.dart';
import 'package:project_expense_tracker/models/expense.dart';
import 'package:project_expense_tracker/widgets/expenses_list/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, required this.removeExpense});
  final List<Expense> expenses;

  final void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    //crea un elenco scrollabile in quanto non si conosce la dimensione della lista
    //costruisce gli elementi solo quando necessario
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
          background: Container(color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal) ,),
          key: ValueKey(expenses[index]), 
          onDismissed: (direction){
            removeExpense(expenses[index]);
          },
          child: ExpensesItem(expenses[index]),),
    );
    //utilizszo dissimissable per l'effetto dello scorrimento dell'elemento
  }
}
