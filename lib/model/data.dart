import 'package:flutter/material.dart';
import 'package:test_docker/model/workout.dart';
import 'package:test_docker/util/storage.dart';

class Data with ChangeNotifier {
  List<Workout>? listWorkout;

  Data(){
    _init();

  }
  void _init() async {
    listWorkout = await Storage.getListWorkout();
    notifyListeners();
  }

  void addWorkout(Workout workout){
    listWorkout?.add(workout);
    notifyListeners();
  }
}