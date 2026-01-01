import 'package:carino/providers/theme_provider.dart';
import 'package:carino/widgets/add_task_dialog.dart';
import 'package:carino/widgets/add_transaction_dialog.dart';
import 'package:carino/models/finance_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget? buildFAB(BuildContext context, int currentIndex) {
  switch (currentIndex) {
    case 0:
      return FloatingActionButton(
        backgroundColor: const Color(0xff6366F1),
        heroTag: 'tasksFab',
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddTaskDialog(),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      );

    case 1:
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'incomeFab',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddTransactionDialog(
                  transactionType: TransactionType.income,
                ),
              );
            },
            backgroundColor: const Color(0xff0CBA80),
            child: const Icon(Icons.trending_up, size: 35, color: Colors.white),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'expenseFab',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const AddTransactionDialog(
                  transactionType: TransactionType.expense,
                ),
              );
            },
            backgroundColor: const Color(0xff6366F1),
            child: const Icon(
              Icons.trending_down,
              size: 35,
              color: Colors.white,
            ),
          ),
        ],
      );

    case 2:
      return FloatingActionButton(
        heroTag: 'themeFab',
        onPressed: () {
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.palette),
      );

    default:
      return null;
  }
}
