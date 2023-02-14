class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todolist() {
    return [
      ToDo(id: '01', todoText: 'Check Mail', isDone: true),
      ToDo(id: '02', todoText: 'Buy Groceries', isDone: true),
      ToDo(id: '03', todoText: 'Write Record',),
      ToDo(id: '04', todoText: 'Be based',),
      ToDo(id: '05', todoText: 'Finish schooling', isDone: true),
    ];
  }
}
