import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_docker/model/workout.dart';
import 'package:test_docker/util/storage.dart';

import '../model/data.dart';
import '../widget/approach_widget.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key, required this.workout, required this.isNew}) : super(key: key);

  final Workout workout;
  final bool isNew;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late Workout _workout;

  @override
  void initState() {
    super.initState();
    _workout = widget.workout;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("WorkoutNote"),
        actions: [
          IconButton(onPressed: (){
            if (widget.isNew){
              Data data = Provider.of<Data>(context, listen: false);
              data.addWorkout(_workout);
              Storage.addListWorkout(_workout);
            } else {
              Storage.setListWorkout(_workout.index, _workout);
            }
            Navigator.of(context).pop();
          }, icon: Icon(Icons.save))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (buildContext, index){
          return ListTile(
            onTap: (){},
            title: Text(_workout.listExercise[index].name),
            subtitle: ApproachWidget(listExercise:_workout.listExercise[index].listApproach ,)
          );
        },
        itemCount: _workout.listExercise.length,
      ),
    );
  }
}
