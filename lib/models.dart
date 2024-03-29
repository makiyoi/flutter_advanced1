import 'package:flutter/material.dart';

@immutable
class ToDo{
  const ToDo({
    required this.id,
    required this.description,
    this.isCompleted = false,
});
  final int id;
  final String description;
  final bool isCompleted;

 // @override
  //String toString() {
    //return 'Todo(description: $description, completed: $isCompleted)';
 // }

  ToDo copyWith({int? id, String? description, bool? isCompleted}) {
    return ToDo(
      id:  id?? this.id,
      description:  description?? this.description,
      isCompleted:  isCompleted?? this.isCompleted,
    );
  }
}



