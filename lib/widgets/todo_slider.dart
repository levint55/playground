import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:playground/dummy_data.dart';
import 'package:playground/providers/todoList.dart';
import 'package:playground/screens/todo_list_detail_screen.dart';
import 'package:provider/provider.dart';

class TodoSlider extends StatefulWidget {
  const TodoSlider({Key? key}) : super(key: key);

  @override
  State<TodoSlider> createState() => _TodoSliderState();
}

class _TodoSliderState extends State<TodoSlider> {
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      // Provider.of<TodoList>(context, listen: false).fetchData();
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 300.0),
      items: Provider.of<TodoList>(context).items.map((item) {
        return Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.check)),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(TodoListDetailScreen.routeName);
                        },
                        icon: const Icon(Icons.edit))
                  ],
                ),
                const Divider(),
                Expanded(
                  child: Center(child: Text('Sample Title')),
                ),
                LinearProgressIndicator(
                  value: 0.5,
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
