import 'package:flutter/material.dart';
import 'package:flutter_advanced_1/models.dart';
import 'package:flutter_advanced_1/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_advanced_1/edit.dart';


class Usually extends ConsumerWidget {  //通常
  const Usually({super.key, required this.title});
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
                    builder: (context) =>  const Edit(barTitle: 'ToDoリスト'))),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer(
              builder: (context, ref, child) {
                final List<ToDo> todoList = ref.watch(todosProvider);
                return ReorderableListView( //並び替え
                  onReorder: (int oldIndex,int newIndex) {
                    ref.read(todosProvider.notifier).rearranges(oldIndex,newIndex);
                    },
                  children: todoList.map<Widget>((ToDo todo) {
                    return Card(
                      key: Key(todo.id.toString()), //id一意の値
                      child: CheckboxListTile(
                        value: todo.isCompleted,
                        checkColor: Colors.green,
                        fillColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                        tileColor: todo.id.isOdd ? Colors.grey[200] : Colors.green[200],
                        title: Text(todo.description, style: TextStyle(
                              decoration: todo.isCompleted ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        onChanged: (value) {
                          ref.read(todosProvider.notifier).toggle(todo.id);
                          },
                      ),
                    );
                  }
                  ).toList(),
                );
              }
              ),
      ),
    );
  }
}
