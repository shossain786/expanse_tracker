import 'package:expanse_tracker/models/expanse.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expanse});

  final Expanse expanse;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(expanse.title),
            const SizedBox(height: 4.0),
            Row(
              children: [
                Text('\$${expanse.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expanse.category]),
                    const SizedBox(width: 8),
                    Text(expanse.formattedDate),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
