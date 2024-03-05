import 'package:flutter/material.dart';
import 'package:project_expense_tracker/models/expense.dart';

//StatefulWidget viene usato nel caso gli elementi allínterno cambiano
class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _prezzoController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
//attivo il calendario e un feature che racchiude un valore ancora non disponibile
  void _presentDatePicker() async {
    //con async ed await aspetta che gli venga assegnato un valore
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpensiveData() {
    final prezzoInserito = double.tryParse(_prezzoController.text);
    final prezzoInvalid =
        prezzoInserito == null || prezzoInserito <= 0; //falso se non e valido
    if (_titleController.text.trim().isEmpty ||
        prezzoInvalid ||
        _selectedDate == null) {
      //messaggio di errore
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Input invalido'),
                content: const Text('Inserire dati validi'),
                actions: [
                  TextButton(
                    onPressed: () {
                      //modo per tornare alla rotta precedente
                      Navigator.pop(ctx);
                    },
                    child: const Text('okay'),
                  )
                ],
              ));
      return;
    }
    //attraverso widget accedo  alle proprieta del widget collegato
    //nuovo elemento
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          prezzo: prezzoInserito,
          data: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    //dispose viene utilizzato per rilasciare le risorse allocate
    _titleController.dispose();
    _prezzoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,48,16,16),
      child: Column(
        children: [
          //text input element
          TextField(
            controller: _titleController,
            //validazione
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _prezzoController,
                  //validazione
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '€',
                    label: Text('amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  //allineamento asse trasversale
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No Date selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    //faccio il set della selezione della categoria
                    setState(() {
                      if (value == null) {
                        return;
                      }
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: _submitExpensiveData,
                  child: const Text('Save Expense'))
            ],
          )
        ],
      ),
    );
  }
}
