import 'exercise.dart';

class Workout{

  int index;
  DateTime date;
  List<Exercise> listExercise;

  Workout({required this.date, required this.index, listExercise})
      : this.listExercise = listExercise != null ? listExercise : [
    Exercise(name: "Leg Press", listApproach: []),
    Exercise(name: "Bench Press", listApproach: []),
    Exercise(name: "Barbell Squats", listApproach: []),
    Exercise(name: "Deadlift", listApproach: []),
    Exercise(name: "Lunges", listApproach: [])
  ];

  Workout.fromJson(Map<String, dynamic> json)
      : date = DateTime.parse(json["date"]),
        index = json["index"],
        listExercise = (json['listExercise'] as List<dynamic>).map((e) =>
            Exercise.fromJson(e)).toList();

  Map<String, dynamic> toJson() => {
    'date': date.toLocal().toString(),
    'listExercise': listExercise,
    'index': index
  };
}