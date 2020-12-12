import 'package:blood_app/api/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SignUpAPI {
  String baseUrl = API.kBASE_URL;

  Future<bool> emailExists(String email) async {
    print(email);
    var response =
        await http.post(baseUrl + "user/emailCheck", body: {"email": email});
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
