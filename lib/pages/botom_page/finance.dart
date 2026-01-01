import 'package:carino/models/finance_model.dart';
import 'package:carino/providers/finance_provider.dart';
import 'package:carino/widgets/expense_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class financePage extends StatelessWidget {
  final Animation<double> scaleAnimation;

  const financePage({super.key, required this.scaleAnimation});

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceProvider>(
      builder: (context, financeProvider, _) {
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Finance', style: TextStyle(fontSize: 25)),
                  Text(
                    'This Month',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff6E71F3),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Icon(Icons.calendar_today_outlined, size: 24),
                  SizedBox(width: 10),
                  Text('December 2025', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff6E71F3),
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Colors.white,
                            size: 28,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Balance',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 5),
                      child: Text(
                        financeProvider.balance.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 42,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        'Looking good!',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            const ExpenseChart(),
            if (financeProvider.recentTransactions.isEmpty)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: ScaleTransition(
                    scale: scaleAnimation,
                    child: Text('No transactions yet.'),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: financeProvider.recentTransactions.length,
                itemBuilder: (context, index) {
                  final transaction =
                      financeProvider.recentTransactions[index];
                  final isIncome =
                      transaction.type == TransactionType.income;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isIncome
                              ? const Color(0xffE9F8F2)
                              : const Color(0xffFCECED),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          isIncome
                              ? Icons.trending_up
                              : Icons.trending_down,
                          color: isIncome
                              ? const Color(0xff0CBA80)
                              : const Color(0xffEF4444),
                        ),
                      ),
                      title: Text(
                        transaction.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      trailing: Text(
                        '${isIncome ? '+' : '-'}₺${transaction.amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isIncome
                              ? const Color(0xff0CBA80)
                              : const Color(0xffEF4444),
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
