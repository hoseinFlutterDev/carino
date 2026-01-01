import 'package:carino/models/finance_model.dart';
import 'package:carino/providers/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransactionDialog extends StatefulWidget {
  final TransactionType transactionType;

  const AddTransactionDialog({super.key, required this.transactionType});

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedCategory;

  final List<String> _categories = [
    'Food',
    'Transport',
    'Shopping',
    'Bills',
    'Entertainment',
    'Health',
    'Education',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _addTransaction() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لطفا عنوان تراکنش را وارد کنید')),
      );
      return;
    }

    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لطفا مبلغ معتبر وارد کنید')),
      );
      return;
    }

    final financeProvider = Provider.of<FinanceProvider>(
      context,
      listen: false,
    );
    final transaction = FinanceTransaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      amount: amount,
      date: DateTime.now(),
      type: widget.transactionType,
      category: widget.transactionType == TransactionType.expense
          ? _selectedCategory
          : null,
    );

    financeProvider.addTransaction(transaction);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = widget.transactionType == TransactionType.income;
    return AlertDialog(
      title: Text(isIncome ? 'افزودن درآمد' : 'افزودن هزینه'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: isIncome ? 'عنوان درآمد' : 'عنوان هزینه',
                border: const OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'مبلغ',
                border: OutlineInputBorder(),
                prefixText: '₺ ',
              ),
              keyboardType: TextInputType.number,
            ),
            if (widget.transactionType == TransactionType.expense) ...[
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'دسته‌بندی',
                  border: OutlineInputBorder(),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('لغو'),
        ),
        ElevatedButton(
          onPressed: _addTransaction,
          style: ElevatedButton.styleFrom(
            backgroundColor: isIncome
                ? const Color(0xff0CBA80)
                : const Color(0xff6366F1),
          ),
          child: const Text('افزودن'),
        ),
      ],
    );
  }
}
