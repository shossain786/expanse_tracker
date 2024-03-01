import 'package:expanse_tracker/models/expanse.dart';
import 'package:expanse_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expanse expenses) onAddExpense;

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
  Categories _categorySelected = Categories.food;

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

  void _submitExpenseData() {
    // final enteredAmount = double.parse(_expenseController.toString());
    final enteredAmount = double.tryParse(_expenseController.text);
    bool invalidAmount = false;
    if (enteredAmount != null) {
      invalidAmount = enteredAmount <= 0;
    }

    if (_titleController.text.trim().isEmpty ||
        enteredAmount == null ||
        invalidAmount ||
        _selectedDateTime == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invlid Input!'),
          content: const Text(
            'Please make sure to enter valid data in title, amount and date fields.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      Expanse(
        amount: double.parse(_expenseController.text),
        category: _categorySelected,
        date: _selectedDateTime!,
        title: _titleController.text,
      ),
    );
    Navigator.pop(context);
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
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _categorySelected,
                items: Categories.values
                    .map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  // debugPrint(value.toString());
                  if (value == null) return;
                  setState(() {
                    _categorySelected = value;
                  });
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 6),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Save Expenses'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
