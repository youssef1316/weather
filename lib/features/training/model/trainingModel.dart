class TrainingModel{
  final List<int> prediction;

  TrainingModel({required this.prediction});

  factory TrainingModel.fromjson(Map<String, dynamic> json) {
    return TrainingModel(
        prediction: List<int>.from(json['prediction']),
    );
  }

  int get isSuitable => prediction.isNotEmpty ? prediction[0] : 0;
}