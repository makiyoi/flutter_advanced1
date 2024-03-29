import 'package:flutter/material.dart';
import 'package:flutter_advanced_1/models.dart';
import 'package:flutter_advanced_1/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Edit extends ConsumerWidget { //編集
  const Edit({Key? key, required this.barTitle}) : super(key: key);
  final String barTitle;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(barTitle),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Consumer(
            builder: (context, ref, child) {
              final List<ToDo> todoList = ref.watch(todosProvider);
              return ReorderableListView(
                onReorder: (int oldIndex, int newIndex) {
                  ref.read(todosProvider.notifier).rearranges(oldIndex, newIndex);
                  },
                header: Card(
                  child: ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('タスク追加'),
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (context) {
                        String text = '';
                        return AlertDialog(
                          title: const Text('タスクを追加'),
                          content: TextField(
                            onChanged: (value) {
                              text = value;
                              },
                          ),
                          actions: <Widget>[
                            TextButton(onPressed: () =>
                                Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(onPressed: () {
                              ref.read(todosProvider.notifier).addTodo(ToDo(id: 0, description: text));
                              Navigator.pop(context, 'OK');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                        },
                    ),
                  ),
                ),
                footer: Card(
                  child: ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('タスク追加'),
                    tileColor: Colors.grey[200],
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (context) {
                        String description = '';
                        return AlertDialog(
                          title: const Text('タスクを追加'),
                          content: TextField(
                            onChanged: (value) {
                              description = value;
                              },
                          ),
                          actions: [
                            TextButton(onPressed: () =>
                                Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(onPressed: () {
                              ref.read(todosProvider.notifier).addTodo(ToDo(id: 1, description: description));
                              Navigator.pop(context, 'OK');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                        },
                    ),
                  ),
                ),
                children: todoList.map<Widget>((ToDo todo) {
                  return Card(
                    key: Key(todo.id.toString()),
                    child: ListTile(
                      tileColor: todo.id.isOdd ? Colors.grey[200] : Colors.green[200],
                      title: Text(todo.description),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, color: Colors.green),
                        onPressed: () {
                          ref.read(todosProvider.notifier).removeTodo(todo.id);
                          },
                      ),
                      onTap: () => showDialog<String>(
                        context: context,
                        builder: (context) {
                          String description = '';
                          return AlertDialog(
                            title: const Text('編集'),
                            content: TextField(
                              onChanged: (value) {
                                description = value;
                                },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  ref.read(todosProvider.notifier).editTodo(id: todo.id,description: description); //編集メソッド
                                      Navigator.pop(context, 'OK');
                                      },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                          },
                      ),
                    ),
                  );
                }).toList(),
              );
            }
            ),
      ),
    );
  }
}