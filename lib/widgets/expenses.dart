import 'package:expanse_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expanse_tracker/models/expanse.dart';
import 'package:expanse_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expense> {
  final List<Expanse> _registeredExpanses = [
    Expanse(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Categories.work,
    ),
    Expanse(
      title: 'Shopping',
      amount: 25.45,
      date: DateTime.now(),
      category: Categories.travel,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      // isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: addExpense),
    );
  }

  void addExpense(Expanse expense) {
    setState(() {
      _registeredExpanses.add(expense);
    });
  }

  void removeExpense(Expanse expanse) {
    final expenseIndex = _registeredExpanses.indexOf(expanse);
    setState(() {
      _registeredExpanses.remove(expanse);
    });
    ScaffoldMessenger.of(context).clearSnackBars(); //to clear existing snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        // showCloseIcon: true,
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpanses.insert(expenseIndex, expanse);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No Exences available. Start adding new expenses'),
    );
    if (_registeredExpanses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpanses,
        onRemoveExpense: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense App'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
