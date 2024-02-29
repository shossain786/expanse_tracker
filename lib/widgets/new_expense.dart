import 'package:expanse_tracker/models/expanse.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // var _enteredTitle = '';
  // void _saveTitleinput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }
  // By using controller its not needed to save the data manually
  final _titleController = TextEditingController();
  final _expenseController = TextEditingController();
  DateTime? _selectedDateTime;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
      initialDate: now,
    );
    setState(() {
      _selectedDateTime = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _expenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
            controller: _titleController,
            // onChanged: _saveTitleinput,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                  controller: _expenseController,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDateTime == null
                          ? 'No date selected'
                          : dateFormatter.format(_selectedDateTime!),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: _presentDatePicker,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Save Expenses'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
