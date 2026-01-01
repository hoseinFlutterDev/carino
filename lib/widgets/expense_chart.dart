import 'package:carino/providers/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceProvider>(
      builder: (context, financeProvider, _) {
        final expensesByCategory = financeProvider.expensesByCategory;

        if (expensesByCategory.isEmpty) {
          return const SizedBox.shrink();
        }

        final totalExpenses = financeProvider.totalExpenses;
        final sortedCategories = expensesByCategory.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value));

        return Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.1),
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Expenses by Category',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(height: 20),
              ...sortedCategories.map((entry) {
                final percentage = (entry.value / totalExpenses * 100);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            entry.key,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '₺${entry.value.toStringAsFixed(2)} (${percentage.toStringAsFixed(1)}%)',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: percentage / 100,
                          minHeight: 8,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getCategoryColor(entry.key),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return const Color(0xffEF4444);
      case 'Transport':
        return const Color(0xff3B82F6);
      case 'Shopping':
        return const Color(0xff8B5CF6);
      case 'Bills':
        return const Color(0xffF59E0B);
      case 'Entertainment':
        return const Color(0xffEC4899);
      case 'Health':
        return const Color(0xff10B981);
      case 'Education':
        return const Color(0xff06B6D4);
      default:
        return const Color(0xff6B7280);
    }
  }
}

