import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:playground/dummy_data.dart';

class TodoSlider extends StatefulWidget {
  const TodoSlider({Key? key}) : super(key: key);

  @override
  State<TodoSlider> createState() => _TodoSliderState();
}

class _TodoSliderState extends State<TodoSlider> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 300.0),
      items: dummy_data.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.check)),
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.more_vert))
                      ],
                    ),
                    Divider(),
                    Expanded(
                      child: Center(child: Text(i.title!)),
                    ),
                    Text('${i.items.length} items'),
                    LinearProgressIndicator(
                      value: i.getProgressValue(),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
