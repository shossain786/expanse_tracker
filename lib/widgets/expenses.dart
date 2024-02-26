import 'package:expanse_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expanse_tracker/models/expanse.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense App'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(
            child: ExpensesList(expenses: _registeredExpanses),
          ),
        ],
      ),
    );
  }
}
