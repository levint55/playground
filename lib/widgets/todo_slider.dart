import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:playground/models/todo_list_arguments.dart';
import 'package:playground/providers/todos_list.dart';
import 'package:playground/screens/todo_list_detail_screen.dart';
import 'package:provider/provider.dart';

class TodoSlider extends StatelessWidget {
  const TodoSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TodosList>(context, listen: false).fetchData(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Consumer<TodosList>(
          builder: (context, value, child) => CarouselSlider(
            options:
                CarouselOptions(height: 300.0, enableInfiniteScroll: false),
            items: value.items.map((item) {
              return Card(
                key: ValueKey(item.id),
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
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.check)),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    TodoListDetailScreen.routeName,
                                    arguments: TodoListArguments(
                                        item.id!, item.title!));
                              },
                              icon: const Icon(Icons.edit))
                        ],
                      ),
                      const Divider(),
                      Expanded(
                        child: Center(child: Text(item.title!)),
                      ),
                      const Text('xx items'),
                      const LinearProgressIndicator(
                        value: 0.5,
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
