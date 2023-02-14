import 'package:flutter/material.dart';
import '../screens/drawer.dart';
import '../constants/colors.dart';
import '../widgets/todoItem.dart';
import '../model/todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoarray = ToDo.todolist();
  List<ToDo> _foundTodo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundTodo = todoarray;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tDBG,
      appBar: _buildAppBar(),
      drawer: mainDrawer(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          "All ToDos",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500),
                        ),
                      ),
                      for (ToDo todoo in _foundTodo.reversed)
                        TodoItem(
                          todo: todoo,
                          onTodoChanged: _handleToDochange,
                          onDelete: _deleteToDo,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _todoController,
                        decoration: InputDecoration(
                            hintText: 'Add new task', border: InputBorder.none),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    child: Text('+', style: TextStyle(fontSize: 40)),
                    onPressed: () {
                      _addToDo(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: tDBlue,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleToDochange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDo(String id) {
    setState(() {
      todoarray.removeWhere((item) => item.id == id);
    });
  }

  void _addToDo(String todo) {
    setState(() {
      todoarray.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo));
    });
    _todoController.clear();
  }

  void _runFilter(String keywrd) {
    List<ToDo> results = [];
    if (keywrd.isEmpty) {
      results = todoarray;
    } else {
      results = todoarray
          .where((item) =>
              item.todoText!.toLowerCase().contains(keywrd.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTodo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tDBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tDGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: tDBlack,
            size: 30,
          ),
        );
      }),
      backgroundColor: tDBG,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        InkWell(
          child: Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/avatar.jpg'),
          ),
        ),
        onTap: (){},
        ),
      ]),
    );
  }
}
