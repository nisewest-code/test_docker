import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_docker/page/workout_page.dart';

import '../model/data.dart';
import '../model/workout.dart';

class ListWorkout extends StatefulWidget {
  const ListWorkout({Key? key}) : super(key: key);

  @override
  State<ListWorkout> createState() => _ListWorkoutState();
}

class _ListWorkoutState extends State<ListWorkout> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(builder: (_, data, child) {
      List list = data.listWorkout ?? [];
      return Scaffold(
        appBar: AppBar(
          title: Text("WorkoutNote"),
        ),
        body: ListView.builder(
          itemBuilder: (buildContext, index) {
            return ListTile(
              title: Text("Workout ${index + 1}"),
              subtitle: Text(list[index].date.toString()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WorkoutPage(
                            workout: list[index],
                            isNew: false,
                          )),
                );
              },
            );
          },
          itemCount: list.length,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WorkoutPage(
                        workout: Workout(
                            date: DateTime.now(), index: list.length + 1),
                        isNew: true,
                      )),
            );
          },
        ),
      );
    });
  }
}
