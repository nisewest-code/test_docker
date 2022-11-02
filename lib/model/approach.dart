class ApproachWeight{
  int weight;
  int countRepeat;
  ApproachWeight({required this.countRepeat,required this.weight});

  ApproachWeight.fromJson(Map<String, dynamic> json)
      : weight = json["weight"],
        countRepeat = json["countRepeat"];

  Map<String, dynamic> toJson() => {
    'countRepeat': countRepeat,
    'weight': weight
  };
}