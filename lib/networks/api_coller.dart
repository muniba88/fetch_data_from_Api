import 'package:dio/dio.dart';
import 'package:featchdata_from_api/networks/apis.dart';

class ApiColler {
  final Dio dio = Dio(); // Create an instance of Dio

  Future<dynamic> get(String endPoint) async {
    try {
      final response = await dio.get('${Apis.baseUrl}$endPoint');

      if (response.statusCode != 200) {
        throw Exception('Failed request: ${response.statusCode}');
      }

      return response
          .data; // Dio already parses the JSON, no need for jsonDecode
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<void> post() async {}
}
