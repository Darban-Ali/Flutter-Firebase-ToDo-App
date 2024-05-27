import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app_2/constants/drawer.dart';
import 'package:todo_app_2/constants/todoitems.dart';
import 'package:todo_app_2/models/todo.dart';
import 'package:todo_app_2/screens/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todoList = ToDo.todoList();
  final todoController = TextEditingController();
  List<ToDo> foundToDo = [];
  ToDo? editingToDo;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  get todoo => null;

  @override
  void initState() {
    foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: SideDrawer(),
      body: Column(
        children: [
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    children: [
                      SearchBox(),
                      Expanded(
                        child: ListView(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 35, bottom: 20),
                              child: const Text(
                                'All To Dos',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 24, 23, 23),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            for (ToDo todoo in foundToDo.reversed)
                              ToDoItem(
                                todo: todoo,
                                onToDoChanged: handleToDoChange,
                                onDeleteItem: handleDelete,
                                onEditItem: handleEdit,
                                isEditing: editingToDo?.id == todoo.id,
                                onSaveEdit: saveEdit,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 204, 196, 196),
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: formkey,
                    child: TextFormField(
                      controller: todoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the task first';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText:
                              'Try typing "Pay utilities bill by Friday 6PM"',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 138, 133, 133))),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: FloatingActionButton(
                  backgroundColor: Color.fromARGB(255, 197, 197, 197),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      addToDoItem(todoController.text);
                    }
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.blue,
                    size: 40,
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  void handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void handleDelete(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void handleEdit(String id) {
    setState(() {
      editingToDo = todoList.firstWhere((todo) => todo.id == id);
    });
  }

  void saveEdit(String id, String newText) {
    setState(() {
      final todo = todoList.firstWhere((todo) => todo.id == id);
      todo.todoText = newText;
      editingToDo = null;
    });
  }

  void addToDoItem(String toDo) {
    setState(() {
      todoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo));
    });
    todoController.clear();
  }

  void runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundToDo = results;
    });
  }

  Widget SearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 204, 196, 196),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                  child: Center(
                child: Text(
                  'To Do App',
                  style: TextStyle(height: 20),
                ),
              )),
              Container(
                height: 40,
                width: 40,
                margin: EdgeInsets.only(left: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.person_2, // Assuming you want to use Icons.person_2
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              )
            ]));
  }
}
