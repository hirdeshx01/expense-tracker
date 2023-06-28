import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BottomOverlay extends StatefulWidget {
  final void Function(ExpenseModel expense) addRegisteredExpenses;
  const BottomOverlay({super.key, required this.addRegisteredExpenses});

  @override
  State<BottomOverlay> createState() {
    return _BottomOverlayState();
  }
}

class _BottomOverlayState extends State<BottomOverlay> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    final parseAmount = double.tryParse(_amountController.text);
    final invalidAmount = parseAmount == null || parseAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        invalidAmount ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid Title, Amount and Date was entered.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
      return;
    } else {
      widget.addRegisteredExpenses(
        ExpenseModel(
            title: _titleController.text,
            amount: parseAmount,
            date: _selectedDate!,
            category: _selectedCategory),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text(
                'Title',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            keyboardType: TextInputType.name,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    prefixText: '₹ ',
                    label: Text(
                      'Amount',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Row(
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No date selected'
                        : DateFormat.yMMMMd().format(_selectedDate!),
                  ),
                  IconButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                            DateTime.now().year - 1,
                            DateTime.now().month,
                            DateTime.now().day,
                          ),
                          lastDate: DateTime.now());
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    },
                    icon: const Icon(Icons.calendar_month),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              DropdownButton(
                  borderRadius: BorderRadius.circular(10),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.name.substring(0, 1).toUpperCase() +
                              e.name.substring(1)),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
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
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Submit'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
