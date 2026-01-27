import 'package:flutter/material.dart';
import 'package:pomodoro_app/components/todo_item.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() {
    return _TodoListState();
  }
}

class _TodoListState extends State<TodoList> {
  // Variables
    // To do list items
  List<String> todoItems = [
    'Example Task 1'
  ];
  // Need adjust later to add to completed items with pomodoro sets

  // List<CompletedItem> completedItems =[];
  List<String> completedItems = [];

  final TextEditingController _textFieldController = TextEditingController();
  bool _isAddingItem = false;

  void _addNewItem() {
  final textController = TextEditingController();
  
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 50, 50, 60),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: textController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Enter task...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    setState(() {
                      todoItems.add(value);
                    });
                    Navigator.pop(context);
                  }
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final text = textController.text.trim();
                        if (text.isNotEmpty) {
                          setState(() {
                            todoItems.add(text);
                          });
                        }
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 193, 127, 255),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text('Add Task'),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
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

// change how items are removed
  // Problem when removing earlier items
  void _onItemCompleted(int index) {
    setState(() {
      final item = todoItems[index];
      todoItems.remove(item);
      completedItems.add(item);
      // print('completed item: $item at index $index');
      // print('Completed items list: $completedItems' );
      // print('To-do items list: $todoItems' );

    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(  // No fixed height
      child: Container(
        padding: EdgeInsets.all(20),  // Changed from margin to padding
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
            
            // The list items
            Column(
              children: todoItems.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                
                return TodoItem(
                  item: item,
                  index: index,
                  onItemCompleted: _onItemCompleted,
                );
              }).toList(),
            ),
            
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
      ),
    
);
}
}