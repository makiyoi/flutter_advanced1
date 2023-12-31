import 'package:flutter/material.dart';
import 'package:flutter_advanced_1/models.dart';
import 'package:flutter_advanced_1/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_advanced_1/edit.dart';


class Usually extends ConsumerWidget {
  Usually({super.key, required this.title,});

 // final List<int> _items = List<int>.generate(4, (int index) => index);
  final String title;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.border_color),
            onPressed: () =>
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Edit(title: 'ToDoリスト',)),),
          ),
        ],
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer(
              builder: (context, ref, child) {
                final List<ToDo> todosList = ref.watch(todosProvider);
                return ReorderableListView(
                  onReorder: (int oldIndex, int newIndex) {
                   // setState((){
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final  ToDo id = todosList.removeAt(oldIndex);
                      todosList.insert(newIndex, id);
                   // });
                    },
                  children: todosList.map<Widget>((ToDo todo) =>//{
                  Card(
                    key:  Key(todo.id.toString()),
                    child: CheckboxListTile(
                      value: todo.isCompleted,
                      checkColor: Colors.green,
                      fillColor: MaterialStateProperty.resolveWith((states) => Colors.transparent), tileColor: Colors.lightGreen[200],//item % 2 == 0 ? Colors.green[200] : Colors.lightGreen[200],
                       title: Text(todo.description,style: TextStyle(decoration: todo.isCompleted? TextDecoration.lineThrough
                       : TextDecoration.none),),
                       onChanged: (value){
                         ref.read(todosProvider.notifier).toggle(todo.id);
                     },
                     ),
                   )
                  ).toList(),
                );
              }
              )
      )
    );
  }
}
