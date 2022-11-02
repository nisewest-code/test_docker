import 'approach.dart';

class Exercise{
  String name;
  List<ApproachWeight> listApproach;

  Exercise({required this.name, required this.listApproach});

  Exercise.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        listApproach = converterJsonToListApproach(json['listApproach']);

  Map<String, dynamic> toJson() => {
    'name': name,
    'listApproach': listApproach
  };

  static ApproachWeight converterJsonToApproach(dynamic json){
    return ApproachWeight.fromJson(json);
  }

  static List<ApproachWeight> converterJsonToListApproach(dynamic json){
    return (json as List<dynamic>).map((e) => converterJsonToApproach(e)).toList();
  }
}