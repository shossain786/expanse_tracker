// ignore_for_file: must_be_immutable

import 'package:expanse_tracker/models/expanse.dart';
import 'package:expanse_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  List<Expanse> expenses;
  final void Function(Expanse expanse) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          margin: Theme.of(context).cardTheme.margin,
          color: Theme.of(context).colorScheme.error.withOpacity(.65),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        key: ValueKey(expenses[index]),
        child: ExpenseItem(expanse: expenses[index]),
      ),
    );
  }
}
