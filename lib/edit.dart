import 'package:flutter/material.dart';
import 'package:flutter_advanced_1/models.dart';
import 'package:flutter_advanced_1/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Edit extends ConsumerWidget {
  Edit({Key? key, required this.title}) : super(key: key);
  final String title;
  final List<int> _items = List<int>.generate(6, (int index) => index);



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final completedTodos= ref.watch(completedTodosProvider);
    //final  unfinishedTodos = ref.watch(unfinishedTodosProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
          backgroundColor: Theme
              .of(context).colorScheme.inversePrimary,
        ),
        body: Padding(
        padding: const EdgeInsets.all(5),
         child: Consumer(
          builder: (context, ref, child) {
            final List<ToDo> todoList = ref.watch(todosProvider);
           ref.listen<List<ToDo>>(unfinishedTodosProvider, (List<ToDo>? previousTodos, List<ToDo> newTodos) {
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
               content: Text('現在${newTodos.length}個の未完了タスクがあります'),
               duration: const Duration(milliseconds: 600),
             ));
            });
            return ReorderableListView(
              header:  Card(
                child: ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text('タスク追加'),
                  onTap: ()=>showDialog<String>(
                    context: context,
                    builder: (context) {
                      String text = '';
                      return AlertDialog(
                        title: const Text('タスクを追加'),
                        content: TextField(
                          onChanged: (value){
                            text = value;
                          },
                        ),
                        actions: <Widget>[
                          TextButton(onPressed:()=>Navigator.pop(context,'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(onPressed: (){
                            ref.read(todosProvider.notifier).addTodo(
                                ToDo(id: DateTime.now().millisecondsSinceEpoch, description: text),
                            );
                            Navigator.pop(context,'OK');
                          },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              //key: const ValueKey('ReorderableListView'),
              onReorder: (int oldIndex, int newIndex) {

                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final int item = _items.removeAt(oldIndex);
                _items.insert(newIndex, item);
              },
              footer:  Card(
                child: ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text('タスク追加'),
                  tileColor: Colors.grey[500],
                  onTap: ()=>showDialog<String>(
                    context: context,
                    builder: (context) {
                      String description = '';
                      return AlertDialog(
                        title: const Text('タスクを追加'),
                        content: TextField(
                          onChanged: (value){
                            description = value;
                          },
                        ),
                        actions: <Widget>[
                          TextButton(onPressed:()=>Navigator.pop(context,'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(onPressed: (){
                            ref.read(todosProvider.notifier).addTodo(
                                ToDo(id: DateTime.now().millisecondsSinceEpoch, description: description),
                            );
                            Navigator.pop(context,'OK');
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
                  key:  Key('$todo'),
                  child: ListTile(
                    tileColor:  Colors.green[200], //: Colors.grey,
                    title: Text(todo.description),
                    trailing: IconButton(
                      icon:  const Icon(Icons.close,color: Colors.green,),
                      onPressed: (){ref.read(todosProvider.notifier).removeTodo(
                          todo.id);
                      },
                    ),
                    onTap: ()=>showDialog<String>(
                      context: context,
                      builder: (context) {
                        String description = '';
                        TextEditingController textEditingController = TextEditingController();
                        return AlertDialog(
                          title: const Text('編集'),
                          content: TextField(
                            onChanged: (value){
                             textEditingController.text = todo.description;
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: ()=>Navigator.pop(context,'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed:(){
                                Navigator.pop(context,'Ok');
                              ref.read(todosProvider.notifier).editTodo(id: todo.id, description: textEditingController.text );
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
          },
        )
        ),
    );
  }
}