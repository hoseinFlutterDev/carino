import 'package:flutter/material.dart';
import '../models/finance_model.dart';

class FinanceProvider extends ChangeNotifier {
  final List<FinanceTransaction> _transactions = [];

  List<FinanceTransaction> get transactions => _transactions;

  double get totalIncome {
    return _transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get totalExpenses {
    return _transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get balance => totalIncome - totalExpenses;

  List<FinanceTransaction> get recentTransactions {
    final sorted = List<FinanceTransaction>.from(_transactions);
    sorted.sort((a, b) => b.date.compareTo(a.date));
    return sorted.take(10).toList();
  }

  void addTransaction(FinanceTransaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  void deleteTransaction(String transactionId) {
    _transactions.removeWhere((t) => t.id == transactionId);
    notifyListeners();
  }

  void updateTransaction(FinanceTransaction updatedTransaction) {
    final index = _transactions.indexWhere(
      (t) => t.id == updatedTransaction.id,
    );
    if (index != -1) {
      _transactions[index] = updatedTransaction;
      notifyListeners();
    }
  }

  Map<String, double> get expensesByCategory {
    final Map<String, double> categoryMap = {};
    for (var transaction in _transactions) {
      if (transaction.type == TransactionType.expense &&
          transaction.category != null) {
        categoryMap[transaction.category!] =
            (categoryMap[transaction.category!] ?? 0) + transaction.amount;
      }
    }
    return categoryMap;
  }
}

