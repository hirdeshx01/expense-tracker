import 'package:expense_tracker/widgets/bottom_overlay.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpensesBackground extends StatefulWidget {
  const ExpensesBackground({super.key});

  @override
  State<ExpensesBackground> createState() {
    return _ExpensesBackgroundState();
  }
}

class _ExpensesBackgroundState extends State<ExpensesBackground> {
  final List<ExpenseModel> _registeredExpenses = [
    ExpenseModel(
      title: 'Flutter Course',
      amount: 830,
      date: DateTime.now(),
      category: Category.work,
    ),
    ExpenseModel(
      title: 'Cinema',
      amount: 500,
      date: DateTime.now(),
      category: Category.leisure,
    )
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      constraints: const BoxConstraints(maxHeight: 550),
      context: context,
      builder: (ctx) => BottomOverlay(
        addRegisteredExpenses: _addRegisteredExpenses,
      ),
    );
  }

  void _addRegisteredExpenses(ExpenseModel expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeRegisteredExpenses(ExpenseModel expense) {
    final deletedExpenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(deletedExpenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget homeContent = const Center(child: Text('Oops, Nothing Here!'));

    if (_registeredExpenses.isNotEmpty) {
      homeContent = ExpensesList(
        registeredExpenses: _registeredExpenses,
        removeRegisteredExpense: _removeRegisteredExpenses,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: homeContent,
          ),
        ],
      ),
    );
  }
}
