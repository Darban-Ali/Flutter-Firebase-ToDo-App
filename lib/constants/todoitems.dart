import 'package:flutter/material.dart';
import '../models/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  final onEditItem;
  final onSaveEdit;
  final bool isEditing;

  const ToDoItem({
    super.key,
    required this.todo,
    required this.onDeleteItem,
    required this.onToDoChanged,
    required this.onEditItem,
    required this.onSaveEdit,
    this.isEditing = false,
  });

  @override
  Widget build(BuildContext context) {
    final editController = TextEditingController(text: todo.todoText);
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 238, 238),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey)),
        child: ListTile(
          onTap: () {
            onToDoChanged(todo);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tileColor: Color.fromARGB(255, 255, 255, 255),
          leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.blue,
          ),
          title: isEditing
              ? TextField(
                  controller: editController,
                  onSubmitted: (newText) {
                    onSaveEdit(todo.id, newText);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Edit To Do',
                  ),
                )
              : Text(
                  todo.todoText!,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
          trailing: Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: 35,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Edit button
                Container(
                  height: 50,
                  width: 50,
                  child: IconButton(
                    color: Color.fromARGB(255, 86, 162, 250),
                    iconSize: 18,
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      onEditItem(todo.id);
                    },
                  ),
                ),
                // Delete button
                Container(
                  height: 50,
                  width: 50,
                  child: IconButton(
                    color: const Color.fromARGB(255, 248, 0, 0),
                    iconSize: 18,
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      onDeleteItem(todo.id);
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
