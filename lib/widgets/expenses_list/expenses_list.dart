import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<ExpenseModel> registeredExpenses;
  final void Function(ExpenseModel expense) removeRegisteredExpense;

  const ExpensesList({
    super.key,
    required this.registeredExpenses,
    required this.removeRegisteredExpense,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: registeredExpenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(registeredExpenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error,
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        onDismissed: (direction) =>
            removeRegisteredExpense(registeredExpenses[index]),
        child: ExpensesListItem(
            registeredExpensesListItem: registeredExpenses[index]),
      ),
    );
  }
}
