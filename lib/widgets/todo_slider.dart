import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:playground/providers/todosList.dart';
import 'package:playground/screens/todo_list_detail_screen.dart';
import 'package:provider/provider.dart';

class TodoSlider extends StatefulWidget {
  const TodoSlider({Key? key}) : super(key: key);

  @override
  State<TodoSlider> createState() => _TodoSliderState();
}

class _TodoSliderState extends State<TodoSlider> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TodosList>(context, listen: false).fetchData(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Consumer<TodosList>(
          builder: (context, value, child) {
            return CarouselSlider(
              options: CarouselOptions(height: 300.0),
              items: value.items.map((item) {
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
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.check)),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      TodoListDetailScreen.routeName);
                                },
                                icon: const Icon(Icons.edit))
                          ],
                        ),
                        const Divider(),
                        Expanded(
                          child: Center(child: Text(item.title!)),
                        ),
                        Text('xx items'),
                        LinearProgressIndicator(
                          value: 0.5,
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}
