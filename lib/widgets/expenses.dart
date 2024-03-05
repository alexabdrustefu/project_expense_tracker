import 'package:flutter/material.dart';
import 'package:project_expense_tracker/widgets/chart/chart.dart';
import 'package:project_expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:project_expense_tracker/models/expense.dart';
import 'package:project_expense_tracker/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

//classe privata
class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    //creo un oggetto
    Expense(
        title: 'Corso Flutter',
        prezzo: 189.99,
        data: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        prezzo: 20.00,
        data: DateTime.now(),
        category: Category.leisure),
  ];

  void _openAddExpensesOverlay() {
    //utilizzo la funzione inntegrata per aprire un modal
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  //metodo per l'aggiunta di un nuovo elemento
  void _addExpense(Expense expense) {
    //con setState comunico a fluttert che c'é stato un cambiamento nel widget
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  //metodo rimozione items
  void _removeExpense(Expense expense) {
    final expenseINdex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Elemento eliminato'),
        action: SnackBarAction(
            label: 'Annulla',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseINdex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    Widget mainContent = const Center(child: Text('Non ci sono elementi!'));
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        removeExpense: _removeExpense,
      );
    }

    //scaffold fornisce una struttura base del progetto
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter expenseTracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpensesOverlay,
            iconSize: 40,
          ),
        ],
      ),
      //aggiungo un Widget column
      body: width<600 ? Column(
        children: [
          Chart(expenses: _registeredExpenses),          //utilizzo expanded per dimensionare la colonna intera
          Expanded(
            child: mainContent,
          ),
        ],
      ): Row(children: [
         Expanded(child: Chart(expenses: _registeredExpenses),),          //utilizzo expanded per dimensionare la colonna intera
          Expanded(
            child: mainContent,
          ),
      ],),
    );
  }
}
//contiene i dati sommati per i grafici per le varei categorie
class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required  this.expenses
  });
//filtro per categoria
//funzione costruttrice
 ExpenseBucket.forCategory(List<Expense> allExpense, this.category) : expenses = allExpense = allExpense.where((el)=> el.category == category).toList();

 final Category category;
 final List<Expense> expenses;
  //metodo get per totalExpenses
  double get totalExpenses{
    double sum=0;
    for(final ex in expenses){
      sum=sum+ex.prezzo; 
    }
    return sum;
  }

} 