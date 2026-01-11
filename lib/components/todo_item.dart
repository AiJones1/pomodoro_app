import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  final String item;
  final int index;
  final Function(int) onItemCompleted;


  const TodoItem({
    super.key,
    required this.item,
    required this.index,
    required this.onItemCompleted,

  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 196, 196, 196),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 193, 127, 255), // Purple when active
      ),
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 1.0),
      child: Row(
        children: [
          // Number
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            child: Text(
              (widget.index + 1).toString(),
              style: TextStyle(
                fontSize: 16,
                color:  Colors.white,
              ),
            ),
          ),
          
          // Task text
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.item,
                style: TextStyle(
                  fontSize: 16,
                  color:  Colors.white,
                ),
              ),
            ),
          ),
          
          // Checkbox
          Checkbox(
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value!;
                
                // Call the appropriate callback
                if (_isChecked) {
                  widget.onItemCompleted(widget.index);
                } 
              });
            },
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}