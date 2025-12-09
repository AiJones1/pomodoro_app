import 'package:flutter/material.dart';
import 'package:pomodoro_app/components/todo_item.dart';

class TodoList extends StatefulWidget {
  final List<String> items;

  const TodoList({super.key, required this.items});

  @override
  State<TodoList> createState() {
    return _TodoListState();
  }
}

class _TodoListState extends State<TodoList> {
  // Variables
    // To do list items
  List<String> todoItems = [
    'Example Task 1',
    'Example Task 2',
    'Example Task 3',
  ];
  final TextEditingController _textFieldController = TextEditingController();
  bool _isAddingItem = false;

  void _addNewItem() {
    setState(() {
      _isAddingItem = true;
    });
  }

  void _saveNewItem() {
    final newItem = _textFieldController.text.trim();
    if(newItem.isNotEmpty){
      setState(() {
        todoItems.add(newItem);
        _isAddingItem = false;
        _textFieldController.clear();
      });
    }
  }

    void _cancel(){
      setState(() {
        _isAddingItem = false;
        _textFieldController.clear();
      });
    }




  @override
  Widget build(BuildContext context) {
    return SizedBox(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'To-Do List',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TodoItem(items: todoItems),
                    const SizedBox(height: 10),


                    // Conditional display of text field and buttons
                    if(_isAddingItem)
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 196, 196, 196),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 193, 127, 255),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 30,
                              alignment: Alignment.center,
                              child: Text(
                                '${todoItems.length + 1}.',
                                style: const TextStyle(fontSize: 16
                                ), 
                              ),
                            ),
                            Expanded(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _textFieldController,
                                  autofocus: true,
                                  style: const TextStyle(fontSize: 16, color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintText: 'Enter new task',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                ),
                                onSubmitted: (value) => _saveNewItem(),
                                ),
                              ),
                            ),
                            // Save and Cancel buttons
                            IconButton(
                              icon: const Icon(Icons.check, color: Colors.white),
                              onPressed: _saveNewItem,
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.white),
                              onPressed: _cancel,
                            ),
                          ],
                        ),
                      )
                  else
                    // Add Item button
                    GestureDetector(
                      onTap: _addNewItem,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 196, 196, 196),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 193, 127, 255),
                        ),
                        padding: const EdgeInsets.all(2.0),
                        margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 1.0),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.add,
                                size: 20,
                              ),
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Add new item...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ),
                            // Empty checkbox placeholder for consistent layout
                            Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.add_circle_outline,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          );
        }
      }