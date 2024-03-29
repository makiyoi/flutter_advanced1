import 'package:flutter_advanced_1/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

  const List<ToDo> todosList = [
    ToDo(id: 1,description: 'task1'),
    ToDo(id: 2,description: 'task2'),
    ToDo(id: 3,description: 'task3'),
 ];

class TodosNotifier extends StateNotifier<List<ToDo>> {
  TodosNotifier() : super(todosList);

  //void addTodo(ToDo newTodo) {
  //  List<ToDo> newState = [];
   // for (final todo in state) {
    //  newState.add(todo);
   // }
   // newState.add(newTodo);
  //  state = newState;
 // }
  int todoId = 4;  //4をtodoIdに代入する

  void addTodo(ToDo todo){//新しく追加される度にidが1ずつ増える
    state = [...state,todo.copyWith(id: todoId++)];
  }

  //void toggle(int id) {
  // List<ToDo> newState = [];
  // for (final todo in state) {
  //  if (todo.id == id) {
  //   newState.add(todo.copyWith(isCompleted: !todo.isCompleted));
  // } else {
  //  newState.add(todo);
  // }
  // }
  //state = newState;
  // }

  void toggle(int id) {
    state = [
      for (final todo in state)
        if(todo.id == id)
          todo.copyWith(isCompleted: !todo.isCompleted)
      else
        todo,
    ];
  }


 //void removeTodo(int todo){
  //  List<ToDo> newState = [];
  //  for(final todo in state){
    //  if(todo.id != id){
     //   newState.add(todo);
    //  }
   // }
   // state =newState;
 // }

  void removeTodo(int id){
    state =[
      for(final todo in state)
        if (todo.id != id) todo,
    ];
  }

 // void editTodo(int id,String description) {  //edit関数書き方①
  //  List<ToDo> newState = [];
   // for (final todo in state) {
     // if (todo.id == id) {
       // newState.add(todo.copyWith(description: description));
     // } else {
     //   newState.add(todo);
    //  }
    //  state = newState;
   // }
 // }
  void editTodo({required int id, required String description}){ //edit関数書き方②
    state= [
      for(final todo in state)
      if(todo.id == id)
         todo.copyWith(description: description)
  else
         todo,
  ];
  }

 void rearranges(int oldIndex, int newIndex ) {
   List<ToDo>  newList = List.from(state); //リストをコピーする
   if (oldIndex < newIndex) {
     newIndex -= 1;
   }
   ToDo todoIndex = newList.removeAt(oldIndex); //コピーしたリストを削除、挿入する
   newList.insert(newIndex, todoIndex);
   state = newList;
 }
}


final todosProvider = StateNotifierProvider<TodosNotifier,List<ToDo>>((ref) {
  return TodosNotifier();
});






