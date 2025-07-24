import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/trainingModel.dart';

class TrainingService {
  final String _baseUrl ='http://10.0.2.2:5001/predict';

  Future<TrainingModel> getTraining (List<int> features) async {
    try{
      print("Sending request");
      final response = await http.post(
          Uri.parse(_baseUrl),
          headers: {'Content-Type' : 'application/json'},
          body: jsonEncode({'features': features})
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(response.body);
        return TrainingModel.fromjson(json);
      } else {
        throw Exception("Error cant get prediction: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error connecting to the ai model: $e");
    }
  }
}