import 'ApiUrl.dart';
import 'package:http/http.dart' as http;


class WebService{

  Future<String> send_postrequest_with_map(Map map) async {
    var baseUrl = ApiUrl.baseUrl ;
    var url = Uri.parse(baseUrl);
    print('BaseUrl of Api : ${baseUrl}  \n ${map} ');

    var response = await http.post(url, body:map);
    print('Response of Api : ${response.body}');
    if (response.statusCode == 200) {
      return response.body;
    }
    else if(response.statusCode == 401) {
      return '{"message": "Unauthenticated","status": 403}';
    }
    else {
      return response.body;
    }
  }


}