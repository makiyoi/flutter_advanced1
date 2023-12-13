//import 'package:flutter/material.dart';
import 'package:flutter_advanced_1/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

  const List<ToDo> todosList = [
    ToDo(id: 0,description: 'task1', isCompleted: false),
    ToDo(id: 1,description: 'task2', isCompleted: false),
    ToDo(id: 2,description: 'task3', isCompleted: false),
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
  void addTodo(ToDo todo){
    state = [...state,todo];
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
 void editTodo(ToDo todo){
    state= [
      for(final todo in state)
        if(todo.id == todo.id)
          todo.copyWith(
            id: todo.id,
            description: todo.description,
            isCompleted: todo.isCompleted,
          )
      else
        todo,
    ];
 }
  void updateTodo(String todo) {
    state = [for (final todo in state) todo];
  }

}






final todosProvider = StateNotifierProvider<TodosNotifier,List<ToDo>>((ref) {
  return TodosNotifier();
});



  final completedTodosProvider =  Provider<List<ToDo>>((ref) {
    final todos = ref.watch(todosProvider);
    return todos.where((todo) => todo.isCompleted).toList();
   });
  final unfinishedTodosProvider =  Provider<List<ToDo>>((ref) {
    final todos = ref.watch(todosProvider);
   return todos.where((todo) => !todo.isCompleted).toList();
  });




