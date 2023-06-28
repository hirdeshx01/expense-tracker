import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { food, leisure, travel, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.skateboarding,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};

class ExpenseModel {
  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return DateFormat.yMMMMd().format(date);
  }
}

class ExpenseBucket {
  final Category category;
  final List<ExpenseModel> expenses;
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<ExpenseModel> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
