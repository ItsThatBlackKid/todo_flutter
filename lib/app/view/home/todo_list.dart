import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.onDelete,
  });

  final String taskName;

  final bool taskCompleted;
  final Function(bool?)? onChanged;

  final Function(BuildContext)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20, bottom: 0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: onDelete,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(15),
              autoClose: true,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.deepPurple,
          ),
          child: Row(
            children: [
              Checkbox(value: taskCompleted, onChanged: onChanged),
              Flexible(
                child: Text(
                  taskName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
