import 'package:blocappapi/constans/strings.dart';
import 'package:dio/dio.dart';

class CharactersWebServices {
  late Dio dio;
  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 100,
      receiveTimeout: 20 * 100,
    );
    dio = Dio(options);
  }
  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('characters');
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> getCharacrerQuote(String characterName) async {
    try {
      Response response =
          await dio.get('quote', queryParameters: {'author': characterName});
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
