class TrainingModel{
  final bool isSuitible;

  TrainingModel({required this.isSuitible});

  factory TrainingModel.fromjson(Map<String, dynamic> json) {
    return TrainingModel(
        isSuitible: json['prediction'][0] == 1,
    );
  }
  
  Map<String, dynamic> toJson(){
    return {
      'isSuitable' : isSuitible? 1 : 0
    };
  }
}