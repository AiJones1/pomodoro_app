import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final List<String> items;

  const TodoItem({super.key, required this.items});
  // Need to implement checkbox and remove from display
  // Will want to store completed items based on pomodoro set
  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map(
        (data){
          int index = items.indexOf(data);

          return Container(
            decoration: BoxDecoration(
              border: 
                Border.all(color: const Color.fromARGB(255, 196, 196, 196),
                width: 1,),
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 193, 127, 255),
            ),
            padding: const EdgeInsets.all(2.0),
            margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 1.0),
            child: Row(
              children: [
                Text((index +1).toString()),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Checkbox(
                  value: false,
                  onChanged: (bool? value) {
                    // Handle checkbox state change
                  },
                ),
              ],
            ),
          );
        }
      ).toList(),
    );

  }
}