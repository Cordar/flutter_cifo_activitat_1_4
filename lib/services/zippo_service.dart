import 'package:http/http.dart' as http;
import 'package:activitat_1_4/models/zippo.dart';

class ZippoService {
  static final ZippoService instance = ZippoService._internal();
  ZippoService._internal();

  final url =
      "https://api.zippopotam.us/es/08907";

  Future<Zippo> fetchDataFromApi() async {
    http.Response response = await http.get(Uri.parse(url));
    final zippopotam = zippoFromJson(response.body);
    return zippopotam;
  }
}