import 'package:carino/models/task_model.dart';
import 'package:carino/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  TaskPriority _selectedPriority = TaskPriority.medium;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _addTask() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لطفا عنوان تسک را وارد کنید')),
      );
      return;
    }

    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final task = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      priority: _selectedPriority,
      dueDate: null,
      isCompleted: false,
    );

    taskProvider.addTask(task);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.all(1),

      title: Center(child: const Text('افزودن تسک جدید')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                alignLabelWithHint: false,
                labelText: 'عنوان تسک',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'توضیحات (اختیاری)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            const Text(': اولویت', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: RadioListTile<TaskPriority>(
                    title: const Text('کم'),
                    value: TaskPriority.low,
                    groupValue: _selectedPriority,
                    onChanged: (value) {
                      setState(() {
                        _selectedPriority = value!;
                      });
                    },
                  ),
                ),

                Expanded(
                  child: Row(
                    children: [
                      Row(
                        children: [
                          RadioMenuButton(
                            value: TaskPriority.medium,
                            groupValue: _selectedPriority,
                            onChanged: (value) {
                              setState(() {
                                _selectedPriority = value!;
                              });
                            },
                            child: Text('متوسط'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RadioListTile<TaskPriority>(
                    title: const Text('زیاد'),
                    value: TaskPriority.high,
                    groupValue: _selectedPriority,
                    onChanged: (value) {
                      setState(() {
                        _selectedPriority = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('لغو'),
        ),
        ElevatedButton(
          onPressed: _addTask,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff6366F1),
          ),
          child: const Text('افزودن', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
