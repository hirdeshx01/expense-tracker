import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpensesListItem extends StatelessWidget {
  const ExpensesListItem({super.key, required this.registeredExpensesListItem});

  final ExpenseModel registeredExpensesListItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              registeredExpensesListItem.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  '₹${registeredExpensesListItem.amount.toStringAsFixed(2)}',
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[registeredExpensesListItem.category]),
                    const SizedBox(width: 12),
                    Text(registeredExpensesListItem.formattedDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
