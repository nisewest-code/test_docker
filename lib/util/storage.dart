import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:test_docker/model/workout.dart';

class Storage{
  static const String _database_name = "storage_d_tz";
  static Future<String?> getValue(String key) async {
    final storage = new LocalStorage(_database_name);
    // bool b = await storage.ready;
    // return b ? storage.getItem(key) : null;
    return storage.ready.then((e) => e ? storage.getItem(key) : null);
  }

  static Future<void> setValue(String key, String value) async{
    final storage = new LocalStorage(_database_name);
    return storage.ready.then((e) => e ? storage.setItem(key, value) : null);
  }

  static Future<List<Workout>> getListWorkout() async {
    return getValue("listWorkout").then((value) => value!=null
        ? (jsonDecode(value) as List<dynamic>).map((e) =>
        Workout.fromJson(e)).toList() : []);
  }

  static Future<void> addListWorkout(Workout workout) async{
    List<Workout>? list = await getListWorkout();
    list.add(workout);
    return setValue("listWorkout", jsonEncode(list));
  }

  static Future<void> removeListWorkout(Workout workout) async {
    List<Workout>? list = await getListWorkout();
    list.remove(workout);
    return setValue("listWorkout", jsonEncode(list));
  }

  static Future<void> setListWorkout(int id, Workout workout) async {
    List<Workout>? list = await getListWorkout();
    list[id] = workout;
    return setValue("listWorkout", jsonEncode(list));
  }
}