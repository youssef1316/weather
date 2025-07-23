import '../service/training_service.dart';
import '../model/trainingModel.dart';

class TrainingUsecase {
  final TrainingService _trainingService;

  TrainingUsecase(this._trainingService);

  Future<TrainingModel> execute (List <int> features) {
    return _trainingService.getTraining(features);
  }
}