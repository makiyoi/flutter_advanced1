import 'package:flutter_advanced_1/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

  const List<ToDo> todosList = [
    ToDo(id: 1,description: 'task1'),
    ToDo(id: 2,description: 'task2'),
    ToDo(id: 3,description: 'task3'),
 ];

class TodosNotifier extends StateNotifier<List<ToDo>> {
  TodosNotifier() : super([]);

  //void addTodo(ToDo newTodo) {
  //  List<ToDo> newState = [];
   // for (final todo in state) {
    //  newState.add(todo);
   // }
   // newState.add(newTodo);
  //  state = newState;
 // }
  void addTodo(ToDo todo){
    int todoId = 4;
    state = [...state,todo];
    todo.copyWith(id: todoId++);
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
    //  if(todo.id != todo.id){
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

//  void editTodo(ToDo todo){
  //  List<ToDo> newState = [];
   // for(final todo in state){
    //  if(todo.id == todo.id){
     //  newState.update(todo);
    //  }
   // }
   // state =newState;
 // }
 void editTodo({required int id, required String description}){  //編集メソッドとして間違っている？
    state= [
      for(final todo in state)
        if(todo.id == todo.id)
          todo.copyWith(
            id: todo.id,
            description: todo.description,
          )
      else
        todo,
    ];
 }
}


final todosProvider = StateNotifierProvider<TodosNotifier,List<ToDo>>((ref) {
  return TodosNotifier();
});



 // final completedTodosProvider =  Provider<List<ToDo>>((ref) {
   // final todos = ref.watch(todosProvider);
  //  return todos.where((todo) => todo.isCompleted).toList();
 //  });
  final unfinishedTodosProvider =  Provider<List<ToDo>>((ref) {
    final todos = ref.watch(todosProvider);
   return todos.where((todo) => !todo.isCompleted).toList();
  });




