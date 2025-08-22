import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_flutter/notifiers/todo_notifier.dart';
import 'package:todo_flutter/utils/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  late TodoModel todoList;

  @override
  void initState() {
    super.initState();
  }

  void checkboxChanged(int index) {
    setState(() {
      todoList.toggleCompleted(index);
    });
  }

  void onDelete(int index) {
    setState(() {
      todoList.removeTodo(index);
      // _controller.clear();
    });
  }

  void saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todos', todoList.toStringList());
  }

  void onAdd() {
    setState(() {
      todoList.addTodo(_controller.text);
      _controller.clear();
      FocusScope.of(context).unfocus(); // Dismiss the keyboard
    });
  }

  void loadTodos() async {
    setState(() {
      todoList.loadTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    todoList = Provider.of<TodoModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Todo '),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              saveTodos();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Todos saved successfully!')),
              );
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, index) {
          var todo = todoList.getTodoAt(index);
          return TodoList(
            taskName: todo.name,
            taskCompleted: todo.completed,
            onChanged: (value) => checkboxChanged(index),
            onDelete: (context) => onDelete(index),
          );
        },
      ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.deepPurple.shade200,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onSubmitted: (_) => onAdd(),
              ),
            ),
          ),
          FloatingActionButton(onPressed: onAdd, child: Icon(Icons.add)),
        ],
      ),
    );
  }
}
