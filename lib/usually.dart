import 'package:flutter/material.dart';
import 'package:flutter_advanced_1/models.dart';
import 'package:flutter_advanced_1/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_advanced_1/edit.dart';


class Usually extends ConsumerWidget {
  const Usually({super.key, required this.title});
 //
  final String title;
 //final List<int> _items = List<int>.generate(10, (int index) => index);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ToDo> todoList = ref.watch(todosProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.border_color),
            onPressed: () =>
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  const Edit(title: 'ToDoリスト'))),
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
                return ReorderableListView( //並び替えが上手くできないのはkeyが間違っている？
                  onReorder: (oldIndex, newIndex) {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                   // ref.read(todosProvider.notifier).rearranges();
                    },
                  children: todoList.map<Widget>((ToDo todo) {
                    return Card(
                        key: Key(todo.id.toString()), //id一意の値
                        child: CheckboxListTile(
                          value: todo.isCompleted,
                          checkColor: Colors.green,
                          fillColor: MaterialStateProperty.resolveWith((
                              states) => Colors.transparent),
                          tileColor: todo.id.isOdd ? Colors.grey[200] : Colors.green[200],
                          title: Text(todo.description, style: TextStyle(
                              decoration: todo.isCompleted ? TextDecoration
                                  .lineThrough
                                  : TextDecoration.none),),
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
